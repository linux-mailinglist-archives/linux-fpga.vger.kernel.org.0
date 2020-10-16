Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823A329099B
	for <lists+linux-fpga@lfdr.de>; Fri, 16 Oct 2020 18:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395433AbgJPQV6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 16 Oct 2020 12:21:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37371 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409973AbgJPQV6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 16 Oct 2020 12:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602865316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BajeG0H3hZ4V02rr1iFzTLXk1wIf+0ghZOJ/ATOsswE=;
        b=CsMqELv9+Dy46MjIA0Fblp2N/HxeydFtHbv+CDUTjhU1vy5kZ7j4NwWyJLgwSMxVKuRVdu
        P/GcN0FCyT+fPIViaVcFLWW4hyxr2UmNgWoG6T+eKsmZMwbKs6xnoar6lW7zsP+2JSJGGk
        awio9eiiYr0Q69sDcRDX2q4BJ2f63Ck=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-NWEwN3zGN8ighiD8chTd8g-1; Fri, 16 Oct 2020 12:21:54 -0400
X-MC-Unique: NWEwN3zGN8ighiD8chTd8g-1
Received: by mail-oi1-f197.google.com with SMTP id b22so1245769oib.8
        for <linux-fpga@vger.kernel.org>; Fri, 16 Oct 2020 09:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BajeG0H3hZ4V02rr1iFzTLXk1wIf+0ghZOJ/ATOsswE=;
        b=nximggFE7Xr7X/U0ywKZQ0pGgs529L1vlJKIPPE5Vx8J3cTSjO2eDuCdAEmFIrYSIs
         rqous42xUGMGhRAnrgApcxWgNSFO5pfHNf9NIfKg3+MJ7n+6IyiwGqFJ1J4dntdLDhfp
         Hm7+QsQsxpuVOotelQEcj1owthrDmxPGFM79EBnQkjMrxVUakKt0jxfNCQWjTWM5P21z
         s9mnj1HExK8I0XqQciyqzf0RTw8COrYr0gNUm3Zfd285F++WqOZNHvnKVoHT1LFw7Gk4
         4gQKjXt9EDTOgz2Go02VTo9GNXrmyyuxr9PTBww31nfzlliH9kKPi0Zn1cDW9Uq6FheF
         LOjg==
X-Gm-Message-State: AOAM533bwtHOvkEOa3Mz9rglnq30T4+DsAGhQ0C5jqAQJvrgPu4En6Xn
        BZOLalI8Hcwl6HCcLinV9PNmE/YkCb+M8kU8LHsjDvG65Lq5Bx9rpyMz4UJKML0JElRNh7q/j0h
        nZI94Z2sYKtps9AkgEFFaJQ==
X-Received: by 2002:a05:6830:3141:: with SMTP id c1mr3018504ots.212.1602865313200;
        Fri, 16 Oct 2020 09:21:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJze7UmuOKJdOpIe5ED8n63O/1ZRrVP3XI3z37mnRGkHOQwcLOW0jpEWBkiF+TcP1H9dwTQVdg==
X-Received: by 2002:a05:6830:3141:: with SMTP id c1mr3018473ots.212.1602865312823;
        Fri, 16 Oct 2020 09:21:52 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d64sm1155593oia.11.2020.10.16.09.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 09:21:52 -0700 (PDT)
Subject: Re: [PATCH 1/2] fpga: dfl: add driver_override support
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, lgoncalv@redhat.com, hao.wu@intel.com
References: <1602828151-24784-1-git-send-email-yilun.xu@intel.com>
 <1602828151-24784-2-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <63d7730b-d9b8-c75d-16f6-3ebb507aabaa@redhat.com>
Date:   Fri, 16 Oct 2020 09:21:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1602828151-24784-2-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/15/20 11:02 PM, Xu Yilun wrote:
> Add support for overriding the default matching of a dfl device to a dfl
> driver. It follows the same way that can be used for PCI and platform
> devices. This patch adds the 'driver_override' sysfs file.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-dfl | 28 ++++++++++++++---
>  drivers/fpga/dfl.c                      | 54 ++++++++++++++++++++++++++++++++-
>  include/linux/dfl.h                     |  2 ++
>  3 files changed, 79 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-dfl b/Documentation/ABI/testing/sysfs-bus-dfl
> index 23543be..db7e8d3 100644
> --- a/Documentation/ABI/testing/sysfs-bus-dfl
> +++ b/Documentation/ABI/testing/sysfs-bus-dfl
> @@ -1,15 +1,35 @@
>  What:		/sys/bus/dfl/devices/dfl_dev.X/type
> -Date:		Aug 2020
> -KernelVersion:	5.10
> +Date:		Oct 2020
> +KernelVersion:	5.11
>  Contact:	Xu Yilun <yilun.xu@intel.com>
>  Description:	Read-only. It returns type of DFL FIU of the device. Now DFL
>  		supports 2 FIU types, 0 for FME, 1 for PORT.
>  		Format: 0x%x
>  
>  What:		/sys/bus/dfl/devices/dfl_dev.X/feature_id
> -Date:		Aug 2020
> -KernelVersion:	5.10
> +Date:		Oct 2020
> +KernelVersion:	5.11
>  Contact:	Xu Yilun <yilun.xu@intel.com>
>  Description:	Read-only. It returns feature identifier local to its DFL FIU
>  		type.
>  		Format: 0x%x

These updates, do not match the comment.

Consider splitting this out.

> +
> +What:           /sys/bus/dfl/devices/.../driver_override
> +Date:           Oct 2020
> +KernelVersion:  5.11
> +Contact:        Xu Yilun <yilun.xu@intel.com>
I am looking at description and trying to make it consistent with sysfs-bus-pci
> +Description:    This file allows the driver for a device to be specified.

'to be specified which will override the standard dfl bus feature id to driver mapping.'


>  When
> +                specified, only a driver with a name matching the value written
> +                to driver_override will have an opportunity to bind to the
> +                device. The override is specified by writing a string to the
> +                driver_override file (echo dfl-uio-pdev > driver_override) and
> +                may be cleared with an empty string (echo > driver_override).
> +                This returns the device to standard matching rules binding.
> +                Writing to driver_override does not automatically unbind the
> +                device from its current driver or make any attempt to
> +                automatically load the specified driver.  If no driver with a
> +                matching name is currently loaded in the kernel, the device
> +                will not bind to any driver.  This also allows devices to
> +                opt-out of driver binding using a driver_override name such as
> +                "none".  Only a single driver may be specified in the override,
> +                there is no support for parsing delimiters.
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 511b20f..bc35750 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -262,6 +262,10 @@ static int dfl_bus_match(struct device *dev, struct device_driver *drv)
>  	struct dfl_driver *ddrv = to_dfl_drv(drv);
>  	const struct dfl_device_id *id_entry;
>  
> +	/* When driver_override is set, only bind to the matching driver */
> +	if (ddev->driver_override)
> +		return !strcmp(ddev->driver_override, drv->name);
> +
>  	id_entry = ddrv->id_table;
>  	if (id_entry) {
>  		while (id_entry->feature_id) {
> @@ -303,6 +307,53 @@ static int dfl_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>  			      ddev->type, ddev->feature_id);
>  }
>  

I am looking at other implementations of driver_override* and looking for consistency.

> +static ssize_t driver_override_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct dfl_device *ddev = to_dfl_dev(dev);
> +	ssize_t len;
> +
> +	device_lock(dev);
> +	len = sprintf(buf, "%s\n", ddev->driver_override);
len = snprintf(buf, PAGE_SIZE ...
> +	device_unlock(dev);
> +	return len;
> +}
> +
> +static ssize_t driver_override_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	struct dfl_device *ddev = to_dfl_dev(dev);
> +	char *driver_override, *old, *cp;
> +
> +	/* We need to keep extra room for a newline */
> +	if (count >= (PAGE_SIZE - 1))
> +		return -EINVAL;
> +
> +	driver_override = kstrndup(buf, count, GFP_KERNEL);
> +	if (!driver_override)
> +		return -ENOMEM;
> +
> +	cp = strchr(driver_override, '\n');
> +	if (cp)
> +		*cp = '\0';
> +
> +	device_lock(dev);
> +	old = ddev->driver_override;
> +	if (strlen(driver_override)) {
> +		ddev->driver_override = driver_override;
> +	} else {
> +		kfree(driver_override);
> +		ddev->driver_override = NULL;
> +	}
> +	device_unlock(dev);
> +
> +	kfree(old);
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(driver_override);
> +
>  static ssize_t
>  type_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> @@ -324,6 +375,7 @@ static DEVICE_ATTR_RO(feature_id);
>  static struct attribute *dfl_dev_attrs[] = {
>  	&dev_attr_type.attr,
>  	&dev_attr_feature_id.attr,
> +	&dev_attr_driver_override.attr,
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(dfl_dev);
> @@ -469,7 +521,7 @@ static int dfl_devs_add(struct dfl_feature_platform_data *pdata)
>  
>  int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *owner)
>  {
> -	if (!dfl_drv || !dfl_drv->probe || !dfl_drv->id_table)
> +	if (!dfl_drv || !dfl_drv->probe)

id_table is still needed for the normal case.

Instead of removing this check, could you add something like

|| (!dfl_drv->is_override && !dfl_drv->id_table)

Tom

>  		return -EINVAL;
>  
>  	dfl_drv->drv.owner = owner;
> diff --git a/include/linux/dfl.h b/include/linux/dfl.h
> index 7affba2f..e1b2471 100644
> --- a/include/linux/dfl.h
> +++ b/include/linux/dfl.h
> @@ -32,6 +32,7 @@ enum dfl_id_type {
>   * @num_irqs: number of IRQs supported by this dfl device.
>   * @cdev: pointer to DFL FPGA container device this dfl device belongs to.
>   * @id_entry: matched id entry in dfl driver's id table.
> + * @driver_override: driver name to force a match
>   */
>  struct dfl_device {
>  	struct device dev;
> @@ -43,6 +44,7 @@ struct dfl_device {
>  	unsigned int num_irqs;
>  	struct dfl_fpga_cdev *cdev;
>  	const struct dfl_device_id *id_entry;
> +	char *driver_override;
>  };
>  
>  /**

