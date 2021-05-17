Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829F33823AC
	for <lists+linux-fpga@lfdr.de>; Mon, 17 May 2021 07:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbhEQFTw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 17 May 2021 01:19:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229625AbhEQFTw (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 17 May 2021 01:19:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CB8C611EE;
        Mon, 17 May 2021 05:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621228716;
        bh=qQ8RHQIdq948yfkD2og+YHDz5XxpMKlE0Njz+Zmp8+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=baFQmmTbqFCgBJ/FGzDVLijz8GbnybJsxIc6G88uVtnvZn83+TS2JzdHZsdAbVOAA
         lLyYO99U+WOsrBNOE2f3xKj8pyU3rIpdZpy9Uh5kp59KV2z1owuVhNrjeNeniBEOOF
         Qki+3+kBhMWcBodTTBAroR7ZhTkvAjtblhEsFPIo=
Date:   Mon, 17 May 2021 07:18:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        moritzf@google.com
Subject: Re: [PATCH 01/12] fpga: sec-mgr: fpga security manager class driver
Message-ID: <YKH8qH9m1j5ubl9y@kroah.com>
References: <20210517023200.52707-1-mdf@kernel.org>
 <20210517023200.52707-2-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517023200.52707-2-mdf@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, May 16, 2021 at 07:31:49PM -0700, Moritz Fischer wrote:
> From: Russ Weight <russell.h.weight@intel.com>
> 
> Create the FPGA Security Manager class driver. The security
> manager provides interfaces to manage secure updates for the
> FPGA and BMC images that are stored in FLASH. The driver can
> also be used to update root entry hashes and to cancel code
> signing keys. The image type is encoded in the image file
> and is decoded by the HW/FW secure update engine.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>

Russ, you know the Intel rules here, why did you not get someone who has
knowledge of the kernel's driver model to review your patches before
sending them out?

Basic driver model review comments below, I'm stopping after reviewing
this one as there's some big failures here...

> +++ b/drivers/fpga/fpga-sec-mgr.c
> @@ -0,0 +1,296 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * FPGA Security Manager
> + *
> + * Copyright (C) 2019-2020 Intel Corporation, Inc.

What year is it?  :(

> + */
> +
> +#include <linux/fpga/fpga-sec-mgr.h>
> +#include <linux/idr.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/vmalloc.h>
> +
> +static DEFINE_IDA(fpga_sec_mgr_ida);
> +static struct class *fpga_sec_mgr_class;
> +
> +struct fpga_sec_mgr_devres {
> +	struct fpga_sec_mgr *smgr;
> +};
> +
> +#define to_sec_mgr(d) container_of(d, struct fpga_sec_mgr, dev)
> +
> +static ssize_t name_show(struct device *dev,
> +			 struct device_attribute *attr, char *buf)
> +{
> +	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
> +
> +	return sysfs_emit(buf, "%s\n", smgr->name);
> +}
> +static DEVICE_ATTR_RO(name);

What is wrong with the name of the device?  Please just use that and do
not have a "second name" of the thing.


> +
> +static struct attribute *sec_mgr_attrs[] = {
> +	&dev_attr_name.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group sec_mgr_attr_group = {
> +	.attrs = sec_mgr_attrs,
> +};
> +
> +static const struct attribute_group *fpga_sec_mgr_attr_groups[] = {
> +	&sec_mgr_attr_group,
> +	NULL,
> +};

ATTRIBUTE_GROUPS()?

> +
> +/**
> + * fpga_sec_mgr_create - create and initialize an FPGA
> + *			  security manager struct
> + *
> + * @dev:  fpga security manager device from pdev
> + * @name: fpga security manager name
> + * @sops: pointer to a structure of fpga callback functions
> + * @priv: fpga security manager private data
> + *
> + * The caller of this function is responsible for freeing the struct
> + * with ifpg_sec_mgr_free(). Using devm_fpga_sec_mgr_create() instead
> + * is recommended.
> + *
> + * Return: pointer to struct fpga_sec_mgr or NULL
> + */
> +struct fpga_sec_mgr *
> +fpga_sec_mgr_create(struct device *dev, const char *name,

Where is the "device" coming from here?  If it's a parent, call it
"parent".

> +		    const struct fpga_sec_mgr_ops *sops, void *priv)
> +{
> +	struct fpga_sec_mgr *smgr;
> +	int id, ret;
> +
> +	if (!name || !strlen(name)) {
> +		dev_err(dev, "Attempt to register with no name!\n");
> +		return NULL;
> +	}
> +
> +	smgr = kzalloc(sizeof(*smgr), GFP_KERNEL);
> +	if (!smgr)
> +		return NULL;
> +
> +	id = ida_simple_get(&fpga_sec_mgr_ida, 0, 0, GFP_KERNEL);

I think we have to only use xarray() calls now, no more new IDA/IDR
calls please.

> +	if (id < 0)
> +		goto error_kfree;
> +
> +	mutex_init(&smgr->lock);
> +
> +	smgr->name = name;
> +	smgr->priv = priv;
> +	smgr->sops = sops;
> +
> +	device_initialize(&smgr->dev);
> +	smgr->dev.class = fpga_sec_mgr_class;
> +	smgr->dev.parent = dev;
> +	smgr->dev.id = id;
> +
> +	ret = dev_set_name(&smgr->dev, "fpga_sec%d", id);

There's your name :)

> +	if (ret) {
> +		dev_err(dev, "Failed to set device name: fpga_sec%d\n", id);
> +		goto error_device;
> +	}
> +
> +	return smgr;
> +
> +error_device:
> +	ida_simple_remove(&fpga_sec_mgr_ida, id);
> +
> +error_kfree:
> +	kfree(smgr);
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(fpga_sec_mgr_create);

Why did you not register the device here.

> +
> +/**
> + * fpga_sec_mgr_free - free an FPGA security manager created
> + *			with fpga_sec_mgr_create()
> + *
> + * @smgr:	FPGA security manager structure
> + */
> +void fpga_sec_mgr_free(struct fpga_sec_mgr *smgr)
> +{
> +	ida_simple_remove(&fpga_sec_mgr_ida, smgr->dev.id);
> +	kfree(smgr);
> +}
> +EXPORT_SYMBOL_GPL(fpga_sec_mgr_free);

Oh look, memory leaks!  :(

More below...


> +
> +static void devm_fpga_sec_mgr_release(struct device *dev, void *res)
> +{
> +	struct fpga_sec_mgr_devres *dr = res;
> +
> +	fpga_sec_mgr_free(dr->smgr);
> +}
> +
> +/**
> + * devm_fpga_sec_mgr_create - create and initialize an FPGA
> + *			       security manager struct
> + *
> + * @dev:  fpga security manager device from pdev
> + * @name: fpga security manager name
> + * @sops: pointer to a structure of fpga callback functions
> + * @priv: fpga security manager private data
> + *
> + * This function is intended for use in a FPGA Security manager
> + * driver's probe function.  After the security manager driver creates
> + * the fpga_sec_mgr struct with devm_fpga_sec_mgr_create(), it should
> + * register it with devm_fpga_sec_mgr_register().
> + * The fpga_sec_mgr struct allocated with this function will be freed
> + * automatically on driver detach.
> + *
> + * Return: pointer to struct fpga_sec_mgr or NULL
> + */
> +struct fpga_sec_mgr *
> +devm_fpga_sec_mgr_create(struct device *dev, const char *name,
> +			 const struct fpga_sec_mgr_ops *sops, void *priv)
> +{
> +	struct fpga_sec_mgr_devres *dr;
> +
> +	dr = devres_alloc(devm_fpga_sec_mgr_release, sizeof(*dr), GFP_KERNEL);
> +	if (!dr)
> +		return NULL;
> +
> +	dr->smgr = fpga_sec_mgr_create(dev, name, sops, priv);
> +	if (!dr->smgr) {
> +		devres_free(dr);
> +		return NULL;
> +	}
> +
> +	devres_add(dev, dr);
> +
> +	return dr->smgr;
> +}
> +EXPORT_SYMBOL_GPL(devm_fpga_sec_mgr_create);
> +
> +/**
> + * fpga_sec_mgr_register - register an FPGA security manager
> + *
> + * @smgr: fpga security manager struct
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +int fpga_sec_mgr_register(struct fpga_sec_mgr *smgr)
> +{
> +	int ret;
> +
> +	ret = device_add(&smgr->dev);
> +	if (ret)
> +		goto error_device;
> +
> +	dev_info(&smgr->dev, "%s registered\n", smgr->name);

Drivers, if working properly, are quiet.  Please remove all dev_info()
mess from here (and the series).

> +
> +	return 0;
> +
> +error_device:
> +	ida_simple_remove(&fpga_sec_mgr_ida, smgr->dev.id);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(fpga_sec_mgr_register);
> +
> +/**
> + * fpga_sec_mgr_unregister - unregister an FPGA security manager
> + *
> + * @mgr: fpga manager struct
> + *
> + * This function is intended for use in an FPGA security manager
> + * driver's remove() function.
> + */
> +void fpga_sec_mgr_unregister(struct fpga_sec_mgr *smgr)
> +{
> +	dev_info(&smgr->dev, "%s %s\n", __func__, smgr->name);

Like this, not needed.

> +
> +	device_unregister(&smgr->dev);
> +}
> +EXPORT_SYMBOL_GPL(fpga_sec_mgr_unregister);
> +
> +static int fpga_sec_mgr_devres_match(struct device *dev, void *res,
> +				     void *match_data)
> +{
> +	struct fpga_sec_mgr_devres *dr = res;
> +
> +	return match_data == dr->smgr;
> +}
> +
> +static void devm_fpga_sec_mgr_unregister(struct device *dev, void *res)
> +{
> +	struct fpga_sec_mgr_devres *dr = res;
> +
> +	fpga_sec_mgr_unregister(dr->smgr);
> +}
> +
> +/**
> + * devm_fpga_sec_mgr_register - resource managed variant of
> + *				fpga_sec_mgr_register()
> + *
> + * @dev: managing device for this FPGA security manager
> + * @smgr: fpga security manager struct
> + *
> + * This is the devres variant of fpga_sec_mgr_register() for which the
> + * unregister function will be called automatically when the managing
> + * device is detached.
> + */
> +int devm_fpga_sec_mgr_register(struct device *dev, struct fpga_sec_mgr *smgr)
> +{
> +	struct fpga_sec_mgr_devres *dr;
> +	int ret;
> +
> +	/*
> +	 * Make sure that the struct fpga_sec_mgr * that is passed in is
> +	 * managed itself.
> +	 */
> +	if (WARN_ON(!devres_find(dev, devm_fpga_sec_mgr_release,
> +				 fpga_sec_mgr_devres_match, smgr)))
> +		return -EINVAL;
> +
> +	dr = devres_alloc(devm_fpga_sec_mgr_unregister, sizeof(*dr), GFP_KERNEL);
> +	if (!dr)
> +		return -ENOMEM;
> +
> +	ret = fpga_sec_mgr_register(smgr);
> +	if (ret) {
> +		devres_free(dr);
> +		return ret;
> +	}
> +
> +	dr->smgr = smgr;
> +	devres_add(dev, dr);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(devm_fpga_sec_mgr_register);
> +
> +static void fpga_sec_mgr_dev_release(struct device *dev)
> +{
> +}

There used to be some lovely documentation in the kernel that said I was
allowed to yell at anyone who did something like this.  But that's
removed, so I'll just be quiet and ask you to think about why you would
ever want to provide an empty function, just to make the kernel core "be
quiet".  Did you perhaps think you were smarter than the kobject core
and this was the proper solution to make it "shut up" with it's crazy
warning that some over-eager developer added?  Or perhaps, that warning
was there on purpose, lovingly hand-added to help provide a HUGE HINT
that not providing a REAL release function was wrong.

You are now required to go and fix this whole series, and get someone
from Intel with some real knowledge of the driver model to sign off on
it, before you are allowed to post the series in public again.

greg k-h
