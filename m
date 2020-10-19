Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2AF292196
	for <lists+linux-fpga@lfdr.de>; Mon, 19 Oct 2020 06:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgJSELZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 19 Oct 2020 00:11:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:11130 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgJSELY (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 19 Oct 2020 00:11:24 -0400
IronPort-SDR: 8qCPiYkJQYVaXoAQgCdo2spPaUzLFybMdSmN3B3RAeYaZcaZl3qa2QsEomB8oaYedlM2ko7DOU
 Yv8iSk65GFZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="153902789"
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="153902789"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2020 21:11:23 -0700
IronPort-SDR: f4UyFY44hpO4eulCnuIdOe1BHsgHRfzeKvIavXqKXb0uluT9UTxB/mafUUtrPaMslnF4DGhSRO
 P+AaWxTutnqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="522965851"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga005.fm.intel.com with ESMTP; 18 Oct 2020 21:11:20 -0700
Date:   Mon, 19 Oct 2020 12:06:13 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        lgoncalv@redhat.com, hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH 1/2] fpga: dfl: add driver_override support
Message-ID: <20201019040612.GA16172@yilunxu-OptiPlex-7050>
References: <1602828151-24784-1-git-send-email-yilun.xu@intel.com>
 <1602828151-24784-2-git-send-email-yilun.xu@intel.com>
 <63d7730b-d9b8-c75d-16f6-3ebb507aabaa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63d7730b-d9b8-c75d-16f6-3ebb507aabaa@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Oct 16, 2020 at 09:21:50AM -0700, Tom Rix wrote:
> 
> On 10/15/20 11:02 PM, Xu Yilun wrote:
> > Add support for overriding the default matching of a dfl device to a dfl
> > driver. It follows the same way that can be used for PCI and platform
> > devices. This patch adds the 'driver_override' sysfs file.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-dfl | 28 ++++++++++++++---
> >  drivers/fpga/dfl.c                      | 54 ++++++++++++++++++++++++++++++++-
> >  include/linux/dfl.h                     |  2 ++
> >  3 files changed, 79 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-dfl b/Documentation/ABI/testing/sysfs-bus-dfl
> > index 23543be..db7e8d3 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-dfl
> > +++ b/Documentation/ABI/testing/sysfs-bus-dfl
> > @@ -1,15 +1,35 @@
> >  What:		/sys/bus/dfl/devices/dfl_dev.X/type
> > -Date:		Aug 2020
> > -KernelVersion:	5.10
> > +Date:		Oct 2020
> > +KernelVersion:	5.11
> >  Contact:	Xu Yilun <yilun.xu@intel.com>
> >  Description:	Read-only. It returns type of DFL FIU of the device. Now DFL
> >  		supports 2 FIU types, 0 for FME, 1 for PORT.
> >  		Format: 0x%x
> >  
> >  What:		/sys/bus/dfl/devices/dfl_dev.X/feature_id
> > -Date:		Aug 2020
> > -KernelVersion:	5.10
> > +Date:		Oct 2020
> > +KernelVersion:	5.11
> >  Contact:	Xu Yilun <yilun.xu@intel.com>
> >  Description:	Read-only. It returns feature identifier local to its DFL FIU
> >  		type.
> >  		Format: 0x%x
> 
> These updates, do not match the comment.
> 
> Consider splitting this out.

I'm sorry it's a typo. The above code should not be changed.

> 
> > +
> > +What:           /sys/bus/dfl/devices/.../driver_override
> > +Date:           Oct 2020
> > +KernelVersion:  5.11
> > +Contact:        Xu Yilun <yilun.xu@intel.com>
> I am looking at description and trying to make it consistent with sysfs-bus-pci
> > +Description:    This file allows the driver for a device to be specified.
> 
> 'to be specified which will override the standard dfl bus feature id to driver mapping.'

Yes, it could be improved.

Actually now it is the "type" and "feature id" matching, the 2 fields
are defined for dfl_driver.id_table. In future for dfl v1, it may be
GUID matching, which will be added to id_table. So how about we make it
more generic:

'to be specified which will override the standard ID table matching.'

> 
> 
> >  When
> > +                specified, only a driver with a name matching the value written
> > +                to driver_override will have an opportunity to bind to the
> > +                device. The override is specified by writing a string to the
> > +                driver_override file (echo dfl-uio-pdev > driver_override) and
> > +                may be cleared with an empty string (echo > driver_override).
> > +                This returns the device to standard matching rules binding.
> > +                Writing to driver_override does not automatically unbind the
> > +                device from its current driver or make any attempt to
> > +                automatically load the specified driver.  If no driver with a
> > +                matching name is currently loaded in the kernel, the device
> > +                will not bind to any driver.  This also allows devices to
> > +                opt-out of driver binding using a driver_override name such as
> > +                "none".  Only a single driver may be specified in the override,
> > +                there is no support for parsing delimiters.
> > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > index 511b20f..bc35750 100644
> > --- a/drivers/fpga/dfl.c
> > +++ b/drivers/fpga/dfl.c
> > @@ -262,6 +262,10 @@ static int dfl_bus_match(struct device *dev, struct device_driver *drv)
> >  	struct dfl_driver *ddrv = to_dfl_drv(drv);
> >  	const struct dfl_device_id *id_entry;
> >  
> > +	/* When driver_override is set, only bind to the matching driver */
> > +	if (ddev->driver_override)
> > +		return !strcmp(ddev->driver_override, drv->name);
> > +
> >  	id_entry = ddrv->id_table;
> >  	if (id_entry) {
> >  		while (id_entry->feature_id) {
> > @@ -303,6 +307,53 @@ static int dfl_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
> >  			      ddev->type, ddev->feature_id);
> >  }
> >  
> 
> I am looking at other implementations of driver_override* and looking for consistency.
> 
> > +static ssize_t driver_override_show(struct device *dev,
> > +				    struct device_attribute *attr, char *buf)
> > +{
> > +	struct dfl_device *ddev = to_dfl_dev(dev);
> > +	ssize_t len;
> > +
> > +	device_lock(dev);
> > +	len = sprintf(buf, "%s\n", ddev->driver_override);
> len = snprintf(buf, PAGE_SIZE ...

It is good to me.

Some bus drivers use snprintf, some use sprintf.

I think it is reasonable snprintf is used here, unlike %d, %u ... it is
uncertain for the output size of %s.

> > +	device_unlock(dev);
> > +	return len;
> > +}
> > +
> > +static ssize_t driver_override_store(struct device *dev,
> > +				     struct device_attribute *attr,
> > +				     const char *buf, size_t count)
> > +{
> > +	struct dfl_device *ddev = to_dfl_dev(dev);
> > +	char *driver_override, *old, *cp;
> > +
> > +	/* We need to keep extra room for a newline */
> > +	if (count >= (PAGE_SIZE - 1))
> > +		return -EINVAL;
> > +
> > +	driver_override = kstrndup(buf, count, GFP_KERNEL);
> > +	if (!driver_override)
> > +		return -ENOMEM;
> > +
> > +	cp = strchr(driver_override, '\n');
> > +	if (cp)
> > +		*cp = '\0';
> > +
> > +	device_lock(dev);
> > +	old = ddev->driver_override;
> > +	if (strlen(driver_override)) {
> > +		ddev->driver_override = driver_override;
> > +	} else {
> > +		kfree(driver_override);
> > +		ddev->driver_override = NULL;
> > +	}
> > +	device_unlock(dev);
> > +
> > +	kfree(old);
> > +
> > +	return count;
> > +}
> > +static DEVICE_ATTR_RW(driver_override);
> > +
> >  static ssize_t
> >  type_show(struct device *dev, struct device_attribute *attr, char *buf)
> >  {
> > @@ -324,6 +375,7 @@ static DEVICE_ATTR_RO(feature_id);
> >  static struct attribute *dfl_dev_attrs[] = {
> >  	&dev_attr_type.attr,
> >  	&dev_attr_feature_id.attr,
> > +	&dev_attr_driver_override.attr,
> >  	NULL,
> >  };
> >  ATTRIBUTE_GROUPS(dfl_dev);
> > @@ -469,7 +521,7 @@ static int dfl_devs_add(struct dfl_feature_platform_data *pdata)
> >  
> >  int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *owner)
> >  {
> > -	if (!dfl_drv || !dfl_drv->probe || !dfl_drv->id_table)
> > +	if (!dfl_drv || !dfl_drv->probe)
> 
> id_table is still needed for the normal case.
> 
> Instead of removing this check, could you add something like
> 
> || (!dfl_drv->is_override && !dfl_drv->id_table)

I don't think it is needed. Seems is_override and !id_table are duplicated
conditions for this implementation. And it may make confusing, e.g. could
a driver been force matched when is_override is not set?

I think we could make it simple, if the dfl driver didn't provide the
id_table, normally it could not match any device. I think it could be
easily understood by dfl driver developers.


Thanks,
Yilun

> 
> Tom
> 
> >  		return -EINVAL;
> >  
> >  	dfl_drv->drv.owner = owner;
> > diff --git a/include/linux/dfl.h b/include/linux/dfl.h
> > index 7affba2f..e1b2471 100644
> > --- a/include/linux/dfl.h
> > +++ b/include/linux/dfl.h
> > @@ -32,6 +32,7 @@ enum dfl_id_type {
> >   * @num_irqs: number of IRQs supported by this dfl device.
> >   * @cdev: pointer to DFL FPGA container device this dfl device belongs to.
> >   * @id_entry: matched id entry in dfl driver's id table.
> > + * @driver_override: driver name to force a match
> >   */
> >  struct dfl_device {
> >  	struct device dev;
> > @@ -43,6 +44,7 @@ struct dfl_device {
> >  	unsigned int num_irqs;
> >  	struct dfl_fpga_cdev *cdev;
> >  	const struct dfl_device_id *id_entry;
> > +	char *driver_override;
> >  };
> >  
> >  /**
