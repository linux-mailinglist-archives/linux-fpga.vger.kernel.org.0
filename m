Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CF61B4C9F
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Apr 2020 20:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgDVSY6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 22 Apr 2020 14:24:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55450 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725648AbgDVSY5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 22 Apr 2020 14:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587579895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fxIemATZr+Jj72Sq0gv/Y8Y0CxRoIaNtcDCWp0Bqo4s=;
        b=E1A4uzto6IDptQIgb2dILXCDEK6LFQP8DQis91yb2A/2zgbNiX+zXFhiaBf6Z+0p56K6Mx
        moqHUDE0W3j8lqNgwZYOrOE87oYNy2tBgd5oRWoOpJLovANW7CIFobcG8+MT+s+7+PBgp7
        eGcwDn+nNH/aVrmxqSQcUUREm4npxYw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-YrdaDg8QM8i7b_6S-DjdBg-1; Wed, 22 Apr 2020 14:24:52 -0400
X-MC-Unique: YrdaDg8QM8i7b_6S-DjdBg-1
Received: by mail-qt1-f199.google.com with SMTP id e44so3695905qta.9
        for <linux-fpga@vger.kernel.org>; Wed, 22 Apr 2020 11:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fxIemATZr+Jj72Sq0gv/Y8Y0CxRoIaNtcDCWp0Bqo4s=;
        b=UtdhBKXrjUdhH3cK+toKcWDFdvmXyRFmMmElc+uWmGowZUCWH3W1+pb8nWtAbZAOqc
         +gmiCGKsNVOhFChBewlZT8M7tD2lC9QVc7wX0gRbILQJsmJscsdKKZSH5HHCDJkA1GkG
         KeG+E4cbXvh7flM8dWUg/6yXNyq7yIzZozsi9yOaRoJ5Z/cf9RYIqbhxe3h/fgQugvgW
         ssfz2yebplUa7VgeiKb4kbg28nL9/c2S4shGhKnaUijT+W5bLuRZd2MzLkzY3lF0mjsl
         TccyYY+/mK83Pl82plQ3iWake5KZWP76XCkeSSzx8uice6/FxK2mLtMf99DOs1iDses4
         HAaA==
X-Gm-Message-State: AGi0PuZqRCqqJ/tfNRORAX9inWNipgbu8yLhl36x1QGstmlXwQf2b9az
        N/SuLfd7GfKs3N9x5rOvavxk8oX+35roriG2G9lYpX71s76y6Pojs+kToX8AOWtJLLV0v3JYfVl
        PD9xL+4/4Bds5c/DT/aP4GQ==
X-Received: by 2002:aed:2d27:: with SMTP id h36mr27910751qtd.228.1587579891774;
        Wed, 22 Apr 2020 11:24:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypLz+UUmoUr3xJ6cMh3LxzwsvUl02i/MbCJdPL1/ZO5RxgnrNGWmZWlAI4BqK7ytrWMDLRWivw==
X-Received: by 2002:aed:2d27:: with SMTP id h36mr27910724qtd.228.1587579891410;
        Wed, 22 Apr 2020 11:24:51 -0700 (PDT)
Received: from trix.remote.csb ([75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o22sm4509050qtm.90.2020.04.22.11.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 11:24:50 -0700 (PDT)
Subject: Re: How to upload fpga firmware
To:     Sascha Hauer <s.hauer@pengutronix.de>, linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
References: <20200422114432.GM1694@pengutronix.de>
From:   Tom Rix <trix@redhat.com>
Message-ID: <cba38c9a-4f13-ce6b-1705-0266b991261f@redhat.com>
Date:   Wed, 22 Apr 2020 11:24:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422114432.GM1694@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

I believe you need to use OPAE, user level interface to the kernel.

Here is a good starting point.

https://opae.github.io/latest/docs/fpga_tools/fpgaconf/fpgaconf.html

Tom

On 4/22/20 4:44 AM, Sascha Hauer wrote:
> Hi,
>
> I wonder what can be done with the mainline state of drivers/fpga/. The
> entry to the framework seems to be fpga_mgr_load(). The only user of
> this function is fpga_region_program_fpga(). This in turn is only called
> in response of applying a device tree overlay. A device tree overlay is
> applied with of_overlay_fdt_apply() which has no users in the Kernel.
>
> My current task is to load a firmware to a FPGA. The code all seems to
> be there in the Kernel, it only lacks a way to trigger it. I am not very
> interested in device tree overlays since the FPGA appears as a PCI
> device (although applying a dtbo could enable the PCIe controller device
> tree node). Is there some mainline way to upload FPGA firmware? At the
> moment we are using the attached patch to trigger loading the firmware
> from userspace. Would something like this be acceptable for mainline?
>
> Sascha
>
> ---------------------------8<----------------------------------
>
> From 71a5ea845dd673d4011391f9e57fdaf427767ed5 Mon Sep 17 00:00:00 2001
> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Date: Tue, 2 Oct 2018 17:13:40 +0200
> Subject: [PATCH] fpga: region: Add sysfs attribute for loading firmware
>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
>  drivers/fpga/fpga-region.c | 50 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index bde5a9d460c5..ca6dc830fadf 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -5,6 +5,7 @@
>   *  Copyright (C) 2013-2016 Altera Corporation
>   *  Copyright (C) 2017 Intel Corporation
>   */
> +#include <linux/device.h>
>  #include <linux/fpga/fpga-bridge.h>
>  #include <linux/fpga/fpga-mgr.h>
>  #include <linux/fpga/fpga-region.h>
> @@ -170,11 +171,58 @@ static ssize_t compat_id_show(struct device *dev,
>  		       (unsigned long long)region->compat_id->id_h,
>  		       (unsigned long long)region->compat_id->id_l);
>  }
> -
>  static DEVICE_ATTR_RO(compat_id);
>  
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
> +
> +static DEVICE_ATTR_RW(firmware_name);
> +
>  static struct attribute *fpga_region_attrs[] = {
>  	&dev_attr_compat_id.attr,
> +	&dev_attr_firmware_name.attr,
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(fpga_region);

