Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C632D1B51F6
	for <lists+linux-fpga@lfdr.de>; Thu, 23 Apr 2020 03:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgDWBgw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 22 Apr 2020 21:36:52 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52126 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgDWBgv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 22 Apr 2020 21:36:51 -0400
Received: by mail-pj1-f67.google.com with SMTP id mq3so1730021pjb.1;
        Wed, 22 Apr 2020 18:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TZq6bba/Za2cfM2s4UaUYLj7V0czmPB9F3lz7Q2Lzpo=;
        b=jK+kKWGF+kN55gPscY/Ah/q7nVK+ddvmipd43rPh8nBRM8K6TbUGdqwf2yudnetSCK
         Q4h8hi2StCM4LQXdYfhCtzcaL6YO13jUjNlwKEh/7nOQYJ1Wu7rSJtwGZud92u8j95+N
         f4uSk7O/0QEOkJea3mDvA0RnnHc2hzzaaOJmDDIyiy879mZeldq4ecMSEjAFuGMyOf7I
         tHfKMb1TOkc4wEQySn0LhS051eE7w/6UwyMKix7r685kmw1u1brzqrnbjkDjmxanfDKZ
         ZUvqRzVZdXnSYXIzuhrssX0JpLHGADumHB/8Pxns7NVVJ95rASS9dvU3Kcp/9739hZFC
         6V9w==
X-Gm-Message-State: AGi0PuZoxgxO9OgGtjpsjhGuWb/58m+Bltc06qMS+e1Ous7d8jSQ2ueQ
        RBIzwQl4SoiozeCs5d5H4OE=
X-Google-Smtp-Source: APiQypLuZz9AxyqwFKbFjw5IcxAxKPR30Avx26+5vdiyhCp6KpPp1XaR6f09JwbRqlC61ZgLJQLSzA==
X-Received: by 2002:a17:902:a40e:: with SMTP id p14mr1410819plq.297.1587605810907;
        Wed, 22 Apr 2020 18:36:50 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id 135sm786680pfu.125.2020.04.22.18.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 18:36:49 -0700 (PDT)
Date:   Wed, 22 Apr 2020 18:36:48 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Moritz Fischer <mdf@kernel.org>
Subject: Re: How to upload fpga firmware
Message-ID: <20200423013648.GA2430@epycbox.lan>
References: <20200422114432.GM1694@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422114432.GM1694@pengutronix.de>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Sascha,

On Wed, Apr 22, 2020 at 01:44:32PM +0200, Sascha Hauer wrote:
> Hi,
> 
> I wonder what can be done with the mainline state of drivers/fpga/. The
> entry to the framework seems to be fpga_mgr_load(). The only user of
> this function is fpga_region_program_fpga(). This in turn is only called
> in response of applying a device tree overlay. A device tree overlay is
> applied with of_overlay_fdt_apply() which has no users in the Kernel.

Yes. It is waiting for dt_overlays one way or another. I personally
don't currently have the bandwidth to work actively on this.

> My current task is to load a firmware to a FPGA. The code all seems to
> be there in the Kernel, it only lacks a way to trigger it. I am not very
> interested in device tree overlays since the FPGA appears as a PCI
> device (although applying a dtbo could enable the PCIe controller device
> tree node). Is there some mainline way to upload FPGA firmware? At the
> moment we are using the attached patch to trigger loading the firmware
> from userspace. Would something like this be acceptable for mainline?

We've looked into this sort of patches over the years and never came to
a general interface that really works.

The OPAE folks (and other users I know of) usually use FPGA Manager with
a higher layer on top of it that moves the bitstream into the kernel via
an ioctl().

One concept I had toyed with mentally, but haven't really gotten around
to implement is a 'discoverable' region, that would deal with the
necessary re-enumeration via a callback and have a sysfs interface
similar to what the patch below has.
This would essentially cover use-cases where you have a discoverable
device implemented in FPGA logic, such as say an FPGA hanging off of
PCIe bus that can get loaded over USB, a CPLD or some other side-band
mechanism. After loading the image you'd have to rescan the PCIe bus -
which - imho is the kernel's job.

What I really wanna avoid is creating another /dev/fpga0 / /dev/xdevcfg
that completely leaves the kernel in the dark about the fact that it
reconfigures a bit of hardware hanging off the bus.

In my ideal world you'd create a pci driver that binds to your device,
and creates mfd style subdevices for whatever you'd want your design to
do. One of these devices would be an FPGA and a FPGA region attached to
that FPGA manager. Your top level driver would co-ordinate the fact that
you are re-programming parts of the FPGA and create / destroy devices as
needed for the hardware contained in the bitstream.

[..]
> +static ssize_t firmware_name_show(struct device *dev,
> +				  struct device_attribute *attr,
> +				  char *buf)
> +{
> +	struct fpga_region *region = to_fpga_region(dev);
> +
> +	if (!region->info || !region->info->firmware_name)
> +		return 0;
> +
> +	return sprintf(buf, "%s\n", region->info->firmware_name);
> +}
> +
> +static ssize_t firmware_name_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *firmware_name, size_t count)
> +{
> +	struct fpga_region *region = to_fpga_region(dev);
> +	struct fpga_image_info *info = region->info;
> +	int error;
> +
> +	if (!info) {
> +		info = fpga_image_info_alloc(dev);
> +		if (!info)
> +			return -ENOMEM;
> +	} else if (info->firmware_name) {
> +		devm_kfree(dev, info->firmware_name);
> +	}
> +
> +	info->firmware_name = devm_kstrdup(dev, firmware_name, GFP_KERNEL);
> +	if (!info->firmware_name)
> +		return -ENOMEM;
> +
> +	if (count >  0 && info->firmware_name[count - 1] == '\n')
> +		info->firmware_name[count - 1] = '\0';
> +
> +	region->info = info;
> +	error = fpga_region_program_fpga(region);
> +	if (error) {
> +		devm_kfree(dev, info->firmware_name);
> +		info->firmware_name = NULL;
> +	}
> +
> +	return error ? error : count;
> +}

Cheers,
Moritz
