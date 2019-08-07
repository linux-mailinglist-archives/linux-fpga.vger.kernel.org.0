Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B12184285
	for <lists+linux-fpga@lfdr.de>; Wed,  7 Aug 2019 04:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfHGCfa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Aug 2019 22:35:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:24924 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfHGCfa (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 6 Aug 2019 22:35:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 19:35:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="373618608"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by fmsmga005.fm.intel.com with ESMTP; 06 Aug 2019 19:35:27 -0700
Date:   Wed, 7 Aug 2019 10:18:19 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Ananda Ravuri <ananda.ravuri@intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v4 04/12] fpga: dfl: afu: add userclock sysfs interfaces.
Message-ID: <20190807021819.GA24158@hao-dev>
References: <1564914022-3710-1-git-send-email-hao.wu@intel.com>
 <1564914022-3710-5-git-send-email-hao.wu@intel.com>
 <20190805155113.GA8107@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805155113.GA8107@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Aug 05, 2019 at 05:51:13PM +0200, Greg KH wrote:
> On Sun, Aug 04, 2019 at 06:20:14PM +0800, Wu Hao wrote:
> > This patch introduces userclock sysfs interfaces for AFU, user
> > could use these interfaces for clock setting to AFU.
> > 
> > Please note that, this is only working for port header feature
> > with revision 0, for later revisions, userclock setting is moved
> > to a separated private feature, so one revision sysfs interface
> > is exposed to userspace application for this purpose too.
> > 
> > Signed-off-by: Ananda Ravuri <ananda.ravuri@intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Acked-by: Alan Tull <atull@kernel.org>
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> > v2: rebased, and switched to use device_add/remove_groups for sysfs
> > v3: update kernel version and date in sysfs doc
> > v4: rebased.
> > ---
> >  Documentation/ABI/testing/sysfs-platform-dfl-port |  35 +++++++
> >  drivers/fpga/dfl-afu-main.c                       | 114 +++++++++++++++++++++-
> >  drivers/fpga/dfl.h                                |   9 ++
> >  3 files changed, 157 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-port b/Documentation/ABI/testing/sysfs-platform-dfl-port
> > index 1ab3e6f..5663441 100644
> > --- a/Documentation/ABI/testing/sysfs-platform-dfl-port
> > +++ b/Documentation/ABI/testing/sysfs-platform-dfl-port
> > @@ -46,3 +46,38 @@ Contact:	Wu Hao <hao.wu@intel.com>
> >  Description:	Read-write. Read or set AFU latency tolerance reporting value.
> >  		Set ltr to 1 if the AFU can tolerate latency >= 40us or set it
> >  		to 0 if it is latency sensitive.
> > +
> > +What:		/sys/bus/platform/devices/dfl-port.0/revision
> > +Date:		August 2019
> > +KernelVersion:	5.4
> > +Contact:	Wu Hao <hao.wu@intel.com>
> > +Description:	Read-only. Read this file to get the revision of port header
> > +		feature.
> 
> What does "revision" mean?
> 
> It feels like you are creating a different set of sysfs files depending
> on the revision field.  Which is fine, sysfs is one-value-per-file and
> userspace needs to handle if the file is present or not.  So why not
> just rely on that and not have to mess with 'revision' at all?  What is
> userspace going to do with that information?

Hi Greg

Thanks for the review and comments,

Yes, different revision of private feature may have different hardware
features, so driver will expose different set of sysfs entries. revision
here is used to help userspace to distinguish them. I think it makes
sense to just rely on if sysfs entry exists or not, manage revision in
userspace code may be quit difficult. Plan to remove this entry in the
next version.

> 
> > +
> > +What:		/sys/bus/platform/devices/dfl-port.0/userclk_freqcmd
> > +Date:		August 2019
> > +KernelVersion:	5.4
> > +Contact:	Wu Hao <hao.wu@intel.com>
> > +Description:	Write-only. User writes command to this interface to set
> > +		userclock to AFU.
> > +
> > +What:		/sys/bus/platform/devices/dfl-port.0/userclk_freqsts
> > +Date:		August 2019
> > +KernelVersion:	5.4
> > +Contact:	Wu Hao <hao.wu@intel.com>
> > +Description:	Read-only. Read this file to get the status of issued command
> > +		to userclck_freqcmd.
> > +
> > +What:		/sys/bus/platform/devices/dfl-port.0/userclk_freqcntrcmd
> > +Date:		August 2019
> > +KernelVersion:	5.4
> > +Contact:	Wu Hao <hao.wu@intel.com>
> > +Description:	Write-only. User writes command to this interface to set
> > +		userclock counter.
> > +
> > +What:		/sys/bus/platform/devices/dfl-port.0/userclk_freqcntrsts
> > +Date:		August 2019
> > +KernelVersion:	5.4
> > +Contact:	Wu Hao <hao.wu@intel.com>
> > +Description:	Read-only. Read this file to get the status of issued command
> > +		to userclck_freqcntrcmd.
> > diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> > index 12175bb..407c97d 100644
> > --- a/drivers/fpga/dfl-afu-main.c
> > +++ b/drivers/fpga/dfl-afu-main.c
> > @@ -142,6 +142,17 @@ static int port_get_id(struct platform_device *pdev)
> >  static DEVICE_ATTR_RO(id);
> >  
> >  static ssize_t
> > +revision_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +	void __iomem *base;
> > +
> > +	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
> > +
> > +	return sprintf(buf, "%x\n", dfl_feature_revision(base));
> > +}
> > +static DEVICE_ATTR_RO(revision);
> > +
> > +static ssize_t
> >  ltr_show(struct device *dev, struct device_attribute *attr, char *buf)
> >  {
> >  	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
> > @@ -276,6 +287,7 @@ static int port_get_id(struct platform_device *pdev)
> >  
> >  static struct attribute *port_hdr_attrs[] = {
> >  	&dev_attr_id.attr,
> > +	&dev_attr_revision.attr,
> >  	&dev_attr_ltr.attr,
> >  	&dev_attr_ap1_event.attr,
> >  	&dev_attr_ap2_event.attr,
> > @@ -284,14 +296,113 @@ static int port_get_id(struct platform_device *pdev)
> >  };
> >  ATTRIBUTE_GROUPS(port_hdr);
> >  
> > +static ssize_t
> > +userclk_freqcmd_store(struct device *dev, struct device_attribute *attr,
> > +		      const char *buf, size_t count)
> > +{
> > +	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
> > +	u64 userclk_freq_cmd;
> > +	void __iomem *base;
> > +
> > +	if (kstrtou64(buf, 0, &userclk_freq_cmd))
> > +		return -EINVAL;
> > +
> > +	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
> > +
> > +	mutex_lock(&pdata->lock);
> > +	writeq(userclk_freq_cmd, base + PORT_HDR_USRCLK_CMD0);
> > +	mutex_unlock(&pdata->lock);
> > +
> > +	return count;
> > +}
> > +static DEVICE_ATTR_WO(userclk_freqcmd);
> > +
> > +static ssize_t
> > +userclk_freqcntrcmd_store(struct device *dev, struct device_attribute *attr,
> > +			  const char *buf, size_t count)
> > +{
> > +	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
> > +	u64 userclk_freqcntr_cmd;
> > +	void __iomem *base;
> > +
> > +	if (kstrtou64(buf, 0, &userclk_freqcntr_cmd))
> > +		return -EINVAL;
> > +
> > +	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
> > +
> > +	mutex_lock(&pdata->lock);
> > +	writeq(userclk_freqcntr_cmd, base + PORT_HDR_USRCLK_CMD1);
> > +	mutex_unlock(&pdata->lock);
> > +
> > +	return count;
> > +}
> > +static DEVICE_ATTR_WO(userclk_freqcntrcmd);
> > +
> > +static ssize_t
> > +userclk_freqsts_show(struct device *dev, struct device_attribute *attr,
> > +		     char *buf)
> > +{
> > +	u64 userclk_freqsts;
> > +	void __iomem *base;
> > +
> > +	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
> > +
> > +	userclk_freqsts = readq(base + PORT_HDR_USRCLK_STS0);
> > +
> > +	return sprintf(buf, "0x%llx\n", (unsigned long long)userclk_freqsts);
> > +}
> > +static DEVICE_ATTR_RO(userclk_freqsts);
> > +
> > +static ssize_t
> > +userclk_freqcntrsts_show(struct device *dev, struct device_attribute *attr,
> > +			 char *buf)
> > +{
> > +	u64 userclk_freqcntrsts;
> > +	void __iomem *base;
> > +
> > +	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
> > +
> > +	userclk_freqcntrsts = readq(base + PORT_HDR_USRCLK_STS1);
> > +
> > +	return sprintf(buf, "0x%llx\n",
> > +		       (unsigned long long)userclk_freqcntrsts);
> > +}
> > +static DEVICE_ATTR_RO(userclk_freqcntrsts);
> > +
> > +static struct attribute *port_hdr_userclk_attrs[] = {
> > +	&dev_attr_userclk_freqcmd.attr,
> > +	&dev_attr_userclk_freqcntrcmd.attr,
> > +	&dev_attr_userclk_freqsts.attr,
> > +	&dev_attr_userclk_freqcntrsts.attr,
> > +	NULL,
> > +};
> > +ATTRIBUTE_GROUPS(port_hdr_userclk);
> > +
> >  static int port_hdr_init(struct platform_device *pdev,
> >  			 struct dfl_feature *feature)
> >  {
> > +	int ret;
> > +
> >  	dev_dbg(&pdev->dev, "PORT HDR Init.\n");
> >  
> >  	port_reset(pdev);
> >  
> > -	return device_add_groups(&pdev->dev, port_hdr_groups);
> > +	ret = device_add_groups(&pdev->dev, port_hdr_groups);
> 
> This all needs to be reworked based on the ability for devices to
> properly add groups when they are bound on probe (the core does it for
> you, no need for the driver to do it.)  But until then, you should at
> least consider:
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * if revision > 0, the userclock will be moved from port hdr register
> > +	 * region to a separated private feature.
> > +	 */
> > +	if (dfl_feature_revision(feature->ioaddr) > 0)
> > +		return 0;
> > +
> > +	ret = device_add_groups(&pdev->dev, port_hdr_userclk_groups);
> > +	if (ret)
> > +		device_remove_groups(&pdev->dev, port_hdr_groups);
> 
> struct attribute_group has is_visible() as a callback to have the core
> show or not show, individual attributes when they are created.  So no
> need for a second group of attributes and you needing to add/remove
> them, just add them all and let the callback handle the "is visible"
> logic.  Makes cleanup _so_ much easier (i.e. you don't have to do it.)

Sure, will use is_visible() here instead in the next version, it does
make thing more clear. Thanks a lot of the comments.

Hao

> 
> thanks,
> 
> greg k-h
