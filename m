Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FC1268F88
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Sep 2020 17:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgINPUS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Sep 2020 11:20:18 -0400
Received: from v-smtpout3.han.skanova.net ([81.236.60.156]:54606 "EHLO
        v-smtpout3.han.skanova.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726396AbgINPTS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Sep 2020 11:19:18 -0400
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Sep 2020 11:19:15 EDT
Received: from [10.175.196.137] ([37.123.169.24])
        by cmsmtp with ESMTPA
        id Hq9mkzXxuxDlhHq9mkfSew; Mon, 14 Sep 2020 17:12:41 +0200
Reply-To: linux-kernel@emagii.com
Subject: Re: How to upload fpga firmware
To:     Moritz Fischer <mdf@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200422114432.GM1694@pengutronix.de>
 <20200423013648.GA2430@epycbox.lan> <20200423062331.GR1694@pengutronix.de>
 <20200425035949.GA11710@epycbox.lan> <20200427064433.GH5877@pengutronix.de>
 <20200430032649.GB6168@epycbox.lan>
From:   Ulf Samuelsson <linux-kernel@emagii.com>
Organization: eMagii
Message-ID: <10a52180-1156-739b-3c24-394c87ee6ff0@emagii.com>
Date:   Mon, 14 Sep 2020 17:12:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200430032649.GB6168@epycbox.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: sv-FI
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfE7GRdBXZcuSaIwlTSn3uCUhzBwxHvJTNjGRtwnkZ4awE7f2Flxfimn9Qg76yeGgqdHdudUoNpPZT7zKgt+NhNnh+ld1vEC/Gh/J9fDqBuN/t9S3bIqP
 FBjiht4UdJ/MF6/meJbd+gNZcWiQfpBG1oip3Pjb0wloxanhMQpm3vF5N+9fvjiUDLiUUtWlOfxQHsfzF+XwgOzYmoM3KZbSJKE//L334H87vzvsVXgFRu/I
 ha1n828HeA7OD0f+kxvnMfpXGZH3gprwCiu4F6qxuZOYuylQfgte3ttraQCvd3a3
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

I just started looking at this for an application.

My plan is to load my FPGAs already in u-boot, but I want them 
upgradeable when running linux as well.

Since I am lazy of nature, I implemented an MTD driver for the FPGA in 
U-boot.

This means that when I do "mtd list", I get

List of MTD devices:

* nand0
   - type: NAND flash
   - block size: 0x40000 bytes
   - min I/O: 0x1000 bytes
   - OOB size: 256 bytes
   - OOB available: 6 bytes
   - ECC strength: 8 bits
   - ECC step size: 512 bytes
   - bitflip threshold: 6 bits
   - 0x000000000000-0x000020000000 : "nand0"
* spif
   - device: sspi-fpga-cfg@2
   - parent: soft-mcspi
   - driver: cyc10
   - type: FPGA
   - block size: 0x10000 bytes
   - min I/O: 0x59d8b bytes
   - 0x000000000000-0x000000059d8b : "spif"
* spyf
   - device: sspy-fpga-cfg@3
   - parent: soft-mcspi
   - driver: cyc10
   - type: FPGA
   - block size: 0x10000 bytes
   - min I/O: 0xaf6e9 bytes
   - 0x000000000000-0x0000000af6e9 : "spyf"
=>


I have a device tree:

&soft_mcspi {
	compatible = "mcspi-gpio";
	pinctrl-names = "default";
	pinctrl-0 = <&soft_mcspi1_pins>;
	status = "okay";
	gpio-sck  = <&gpio0 7 GPIO_ACTIVE_HIGH>;
	gpio-miso = <&gpio1 8 GPIO_ACTIVE_HIGH>;
	gpio-mosi = <&gpio1 9 GPIO_ACTIVE_HIGH>;
	cs-gpios =
	   <&gpio0 12 GPIO_ACTIVE_LOW>,	
	   <&gpio0 13 GPIO_ACTIVE_LOW>,	
	   <&gpio0 17 GPIO_ACTIVE_LOW>,	
	   <&gpio0 16 GPIO_ACTIVE_LOW>;	
	num-chipselects = <4>;
	#address-cells = <1>;
	#size-cells = <0>;
	....
	sspi-fpga-cfg@2 {	/* Intel Cyclone 10, 10CL010 */
		#address-cells = <1>;
		#size-cells = <1>;
		compatible = "intel,cyclone10";
		reg = <2>; /* Chip select 0 */
		spi-max-frequency = <1000000>;
		fpga = "spif";
		config-size	= <368011>;
		gpio-nconfig	= <&gpio3 15 GPIO_ACTIVE_HIGH>;	
		gpio-nstatus	= <&gpio3 19 GPIO_ACTIVE_HIGH>;	
		gpio-conf_done	= <&gpio3 18 GPIO_ACTIVE_HIGH>;	
		gpio-crc_error	= <&gpio2  1 GPIO_ACTIVE_HIGH>;	
	};
	sspy-fpga-cfg@3 {	/* Intel Cyclone 10, 10CL025 */
		#address-cells = <1>;
		#size-cells = <1>;
		compatible = "intel,cyclone10";
		reg = <3>; /* Chip select 0 */
		spi-max-frequency = <1000000>;
		fpga = "spyf";
		config-size	= <718569>;
		gpio-nconfig	= <&gpio3 21 GPIO_ACTIVE_HIGH>;
		gpio-nstatus	= <&gpio3 17 GPIO_ACTIVE_HIGH>;
		gpio-conf_done	= <&gpio0 18 GPIO_ACTIVE_HIGH>;
		gpio-crc_error	= <&gpio2 18 GPIO_ACTIVE_HIGH>;
	};
};

programming the FPGA in u-boot is done by the mtd command

mmc rescan
fatload mmc 0:1 spif.rbf 0x82000000
mtd write.raw spif 0x82000000

So no new commands needed. No specific FPGA support.
Just a Cyclone MTD driver.

============================

The device tree adds config-size, and a way to name it,
as well as the crc error signal (which I am yet to use)

============================

If the linux FPGA driver would be implemented as an MTD
driver, then it would be quite easy to program the FPGA

$ cat spif_configuration.rbf > /dev/spif
$ cat spyf_configuration.rbf > /dev/spyf

the mtd device would  not support erase and reads will always return all 
zeros, so it is a write-only mtd device, LOL!

============================

The way we implemented our H/W (Cyclone 10LP), the FPGA chip selects are 
just ordinary GPIO in the processor, so the are not tied to ground.

All FPGAs can be programmed separately.

Intel applications notes thinks that multiple FPGAs should connected in 
a chip select daisy chain, and then you need to do

$ cat fpga0.rbf fpga1.rbf > /dev/fpga

The config-size needs to be set to the total sum of the configuration files.

The CPU should do a single SPI transfer, and set the LSB bit in the 
flags (which the SPI driver needs to support). The current Alter/Intel
driver will manually bit-reverse each word to MSB first, which is no good.

============================

Do you guys think that implementing FPGA programming as MTD devices 
makes sense?

/Ulf

Den 2020-04-30 kl. 05:26, skrev Moritz Fischer:
> On Mon, Apr 27, 2020 at 08:44:33AM +0200, Sascha Hauer wrote:
>> On Fri, Apr 24, 2020 at 08:59:49PM -0700, Moritz Fischer wrote:
>>> Hi Sascha,
>>>
>>> On Thu, Apr 23, 2020 at 08:23:31AM +0200, Sascha Hauer wrote:
>>>> Hi Moritz,
>>>>
>>>> On Wed, Apr 22, 2020 at 06:36:48PM -0700, Moritz Fischer wrote:
>>>>> Hi Sascha,
>>>>>
>>>>> On Wed, Apr 22, 2020 at 01:44:32PM +0200, Sascha Hauer wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I wonder what can be done with the mainline state of drivers/fpga/. The
>>>>>> entry to the framework seems to be fpga_mgr_load(). The only user of
>>>>>> this function is fpga_region_program_fpga(). This in turn is only called
>>>>>> in response of applying a device tree overlay. A device tree overlay is
>>>>>> applied with of_overlay_fdt_apply() which has no users in the Kernel.
>>>>>
>>>>> Yes. It is waiting for dt_overlays one way or another. I personally
>>>>> don't currently have the bandwidth to work actively on this.
>>>>>
>>>>>> My current task is to load a firmware to a FPGA. The code all seems to
>>>>>> be there in the Kernel, it only lacks a way to trigger it. I am not very
>>>>>> interested in device tree overlays since the FPGA appears as a PCI
>>>>>> device (although applying a dtbo could enable the PCIe controller device
>>>>>> tree node). Is there some mainline way to upload FPGA firmware? At the
>>>>>> moment we are using the attached patch to trigger loading the firmware
>>>>>> from userspace. Would something like this be acceptable for mainline?
>>>>>
>>>>> We've looked into this sort of patches over the years and never came to
>>>>> a general interface that really works.
>>>>>
>>>>> The OPAE folks (and other users I know of) usually use FPGA Manager with
>>>>> a higher layer on top of it that moves the bitstream into the kernel via
>>>>> an ioctl().
>>>>>
>>>>> One concept I had toyed with mentally, but haven't really gotten around
>>>>> to implement is a 'discoverable' region, that would deal with the
>>>>> necessary re-enumeration via a callback and have a sysfs interface
>>>>> similar to what the patch below has.
>>>>> This would essentially cover use-cases where you have a discoverable
>>>>> device implemented in FPGA logic, such as say an FPGA hanging off of
>>>>> PCIe bus that can get loaded over USB, a CPLD or some other side-band
>>>>> mechanism. After loading the image you'd have to rescan the PCIe bus -
>>>>> which - imho is the kernel's job.
>>>>>
>>>>> What I really wanna avoid is creating another /dev/fpga0 / /dev/xdevcfg
>>>>> that completely leaves the kernel in the dark about the fact that it
>>>>> reconfigures a bit of hardware hanging off the bus.
>>>>
>>>> Yes, makes sense. While this would suffice my needs at the moment it
>>>> really sounds like a dead end.
>>>>
>>>>>
>>>>> In my ideal world you'd create a pci driver that binds to your device,
>>>>> and creates mfd style subdevices for whatever you'd want your design to
>>>>> do. One of these devices would be an FPGA and a FPGA region attached to
>>>>> that FPGA manager. Your top level driver would co-ordinate the fact that
>>>>> you are re-programming parts of the FPGA and create / destroy devices as
>>>>> needed for the hardware contained in the bitstream.
>>>>
>>>> In my case there is no pci device visible before loading the firmware,
>>>> so creating a pci driver is not an option. Maybe pci host controllers
>>>> could register themselves as fpga-bridges. With this we could put the
>>>> pci host controller (or the pci device, AFAIK there is a PCI device tree
>>>> binding) where the fpga is connected into the fpga-bridges phandles list
>>>> of the fpga-region.
>>>
>>> Can you talk a bit more about the system you're working with? Is there
>>> some sort of sideband mechanism to load the image? What exposes the
>>> image loading capaibility? A CPLD, an ASIC, USB device, JTAG?
>>
>> We have two systems. One uploads the FPGA firmware via SPI passive
>> serial mode (compatible fpga-arria10-passive-serial). The other system
>> has a ftdi FT232H USB/serial converter chip working in synchronous FIFO
>> mode, connected to the FPGA via a CPLD. The series from Anatolij Gustchin
>> here https://patchwork.kernel.org/cover/10824743/ would have been useful
>> for us, although of course our CPLD has a different protocol. On this
>> system we currently ended up with a small custom driver which bypasses
>> FPGA manager and only uploads the firmware at USB connect time.
> 
> Yeah this seems imho the only legit use-case for a something like the
> sysfs entry for the fpga-region. That being said once we add that, it's
> going to become ABI and everyone is gonna use that instead of
> implementing a proper driver using FPGA Regions to deal with
> re-enumeration.
> 
> We don't really have a good way of modelling systems where the bus is
> 100% discoverable (like a PCI device), but only after we load firmware.
> 
> I mean you could implement a FPGA manager for your CPLD that also
> instantiates a region that you then target when you want to reprogram
> the FPGA region. How you'd tie that together though with the PCI device
> to get the bus to be re-enumerated as part of reprogramming the region,
> I'm not 100% sure :)
> 
>>> It also depends a bit on the use-case: After you program the bitstream,
>>> do you need to runtime re-program it? Does it do partial
>>> reconfiguration? Are there subdevices inside your device, or is the
>>> whole thing a discoverable PCI device afterwards?
>>
>> On both systems It's one PCI device only. Currently we don't need runtime
>> re-programming, although this might be useful in the future. Also there's
>> no partial reconfiguration.
>>
> 
> Sorry for the late response, things are busy at the moment.
> 
> Cheers,
> Moritz
> 

-- 
Best Regards
Ulf Samuelsson
