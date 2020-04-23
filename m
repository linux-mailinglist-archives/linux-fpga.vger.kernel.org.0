Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1081B5402
	for <lists+linux-fpga@lfdr.de>; Thu, 23 Apr 2020 07:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgDWFMW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 23 Apr 2020 01:12:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:37814 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgDWFMV (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 23 Apr 2020 01:12:21 -0400
IronPort-SDR: WrhYc+t6JOklM1PUaz60L6OKaRrTcVjckYaBWBGx7BZJjlvDplEinWkHLxDnQgIQhTcpC4XtnV
 3vzqHIQliPQQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 22:12:21 -0700
IronPort-SDR: CaLeYimjrE1X7uWVc9FtYpX1vYLIdIO3dWZk/8E64x85IpEKhr0IbiEnZ4StGXbr+va5BgiGpm
 84jyyHJAt8tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,305,1583222400"; 
   d="scan'208";a="365895105"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga001.fm.intel.com with ESMTP; 22 Apr 2020 22:12:19 -0700
Date:   Thu, 23 Apr 2020 13:09:34 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: How to upload fpga firmware
Message-ID: <20200423050934.GC30060@yilunxu-OptiPlex-7050>
References: <20200422114432.GM1694@pengutronix.de>
 <20200423013648.GA2430@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423013648.GA2430@epycbox.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz:

On Wed, Apr 22, 2020 at 06:36:48PM -0700, Moritz Fischer wrote:
> Hi Sascha,
> 
> On Wed, Apr 22, 2020 at 01:44:32PM +0200, Sascha Hauer wrote:
> > Hi,
> > 
> > I wonder what can be done with the mainline state of drivers/fpga/. The
> > entry to the framework seems to be fpga_mgr_load(). The only user of
> > this function is fpga_region_program_fpga(). This in turn is only called
> > in response of applying a device tree overlay. A device tree overlay is
> > applied with of_overlay_fdt_apply() which has no users in the Kernel.
> 
> Yes. It is waiting for dt_overlays one way or another. I personally
> don't currently have the bandwidth to work actively on this.
> 
> > My current task is to load a firmware to a FPGA. The code all seems to
> > be there in the Kernel, it only lacks a way to trigger it. I am not very
> > interested in device tree overlays since the FPGA appears as a PCI
> > device (although applying a dtbo could enable the PCIe controller device
> > tree node). Is there some mainline way to upload FPGA firmware? At the
> > moment we are using the attached patch to trigger loading the firmware
> > from userspace. Would something like this be acceptable for mainline?
> 
> We've looked into this sort of patches over the years and never came to
> a general interface that really works.
> 
> The OPAE folks (and other users I know of) usually use FPGA Manager with
> a higher layer on top of it that moves the bitstream into the kernel via
> an ioctl().
> 
> One concept I had toyed with mentally, but haven't really gotten around
> to implement is a 'discoverable' region, that would deal with the
> necessary re-enumeration via a callback and have a sysfs interface
> similar to what the patch below has.
> This would essentially cover use-cases where you have a discoverable
> device implemented in FPGA logic, such as say an FPGA hanging off of
> PCIe bus that can get loaded over USB, a CPLD or some other side-band
> mechanism. After loading the image you'd have to rescan the PCIe bus -
> which - imho is the kernel's job.

Seems you mentioned the static region update. I have the pcie based FPGA
card, and the pcie endpoint is implemented in FPGA static region. So after
I have written image into Flash (over USB or other ways), and trying to
load it to FPGA, the pcie endpoint is also disfunctional, the pcie device
is actually lost. We need to rescan the pcie bus after loading is finished.

The concern is that when the pcie device lost, the 'discoverable' region
created by the pcie driver is also destroyed. When you rescaned the pcie
device back, it is like everything is start over again (pci probe, fpga
region creation, subdev enumeration ...) rather than just a re-enumeration
callback for discoverable region.

How do you think about it?

> 
> What I really wanna avoid is creating another /dev/fpga0 / /dev/xdevcfg
> that completely leaves the kernel in the dark about the fact that it
> reconfigures a bit of hardware hanging off the bus.

I have the FPGA board whose image binary for static region is stored in Flash.
I was able to enumerate the Flash as MTD device and update it directly, (now
switch to another interface for security support). 
Do you mean I should avoid doing that cause FPGA region device is unaware of
the update? Some interface in FPGA region would be better choice?

Thanks!

> 
> In my ideal world you'd create a pci driver that binds to your device,
> and creates mfd style subdevices for whatever you'd want your design to
> do. One of these devices would be an FPGA and a FPGA region attached to
> that FPGA manager. Your top level driver would co-ordinate the fact that
> you are re-programming parts of the FPGA and create / destroy devices as
> needed for the hardware contained in the bitstream.
> 
> [..]
> > +static ssize_t firmware_name_show(struct device *dev,
> > +				  struct device_attribute *attr,
> > +				  char *buf)
> > +{
> > +	struct fpga_region *region = to_fpga_region(dev);
> > +
> > +	if (!region->info || !region->info->firmware_name)
> > +		return 0;
> > +
> > +	return sprintf(buf, "%s\n", region->info->firmware_name);
> > +}
> > +
> > +static ssize_t firmware_name_store(struct device *dev,
> > +				   struct device_attribute *attr,
> > +				   const char *firmware_name, size_t count)
> > +{
> > +	struct fpga_region *region = to_fpga_region(dev);
> > +	struct fpga_image_info *info = region->info;
> > +	int error;
> > +
> > +	if (!info) {
> > +		info = fpga_image_info_alloc(dev);
> > +		if (!info)
> > +			return -ENOMEM;
> > +	} else if (info->firmware_name) {
> > +		devm_kfree(dev, info->firmware_name);
> > +	}
> > +
> > +	info->firmware_name = devm_kstrdup(dev, firmware_name, GFP_KERNEL);
> > +	if (!info->firmware_name)
> > +		return -ENOMEM;
> > +
> > +	if (count >  0 && info->firmware_name[count - 1] == '\n')
> > +		info->firmware_name[count - 1] = '\0';
> > +
> > +	region->info = info;
> > +	error = fpga_region_program_fpga(region);
> > +	if (error) {
> > +		devm_kfree(dev, info->firmware_name);
> > +		info->firmware_name = NULL;
> > +	}
> > +
> > +	return error ? error : count;
> > +}
> 
> Cheers,
> Moritz
