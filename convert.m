% convert - Program to perform units conversion for length
clear all;      %@ Clear memory
help convert;   %@ Print header comment

%@ Select units to be input and output
fprintf('Length units: \n');
fprintf(' 1) Centimeters   2) Meters   3) Kilometers \n');
fprintf(' 4) Inches        5) Feet     6) Miles      \n');
InUnits = input('Select units for input values: ');
OutUnits = input('Select units for output values: ');

%@ Initialize constants for conversion to and from meters
ConvertToMeters = [0.01, 1.00, 1000.0, 0.0254, 0.3048, 1609.3];
for i=1:6
  ConvertFromMeters(i) = 1./ConvertToMeters(i);
end

%@ Enter value to be converted
Value = input('Enter value to be converted (zero to quit): ');

%@ While value to be converted is NOT zero
while( Value ~= 0 )
  %@ Convert input value into meters
  ValueMeters = Value*ConvertToMeters(InUnits);
  %@ Convert from meters to output units
  NewValue = ValueMeters*ConvertFromMeters(OutUnits);
  %@ Print the converted value
  fprintf('Converted value is %g \n',NewValue);
  %@ Prompt for next input value
  Value = input('Enter value to be converted (zero to quit): ');
end
