Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4F0848A4
	for <lists+linux-fpga@lfdr.de>; Wed,  7 Aug 2019 11:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfHGJbD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 7 Aug 2019 05:31:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfHGJbD (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 7 Aug 2019 05:31:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D81021E6E;
        Wed,  7 Aug 2019 09:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565170261;
        bh=vb+2JbWok7uCdzhlzJUydNKGMSOIe/oIREEFR0o8Q5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yPgayrDlPGj4+EKo/OxFyb2gh7u63YnJ7AJeHwpu9NcJnwjRTXhegOM/3T/aJF1TL
         giuf09lxtJ/ea+qpJUDu4+nJzUSL9DIjIVVdph3IJV2MoCH8WVV+4BHjmYxWQdF+pt
         fWY8RY6o96ybDVuLSaVUuzFXXJrBaecmm1x/kaH0=
Date:   Wed, 7 Aug 2019 11:30:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Luwei Kang <luwei.kang@intel.com>,
        Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v4 11/12] fpga: dfl: fme: add global error reporting
 support
Message-ID: <20190807093058.GA8326@kroah.com>
References: <1564914022-3710-1-git-send-email-hao.wu@intel.com>
 <1564914022-3710-12-git-send-email-hao.wu@intel.com>
 <20190805155626.GD8107@kroah.com>
 <20190807024521.GD24158@hao-dev>
 <20190807080825.GA10344@hao-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807080825.GA10344@hao-dev>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Aug 07, 2019 at 04:08:25PM +0800, Wu Hao wrote:
> On Wed, Aug 07, 2019 at 10:45:22AM +0800, Wu Hao wrote:
> > On Mon, Aug 05, 2019 at 05:56:26PM +0200, Greg KH wrote:
> > > On Sun, Aug 04, 2019 at 06:20:21PM +0800, Wu Hao wrote:
> > > > +static int fme_global_err_init(struct platform_device *pdev,
> > > > +			       struct dfl_feature *feature)
> > > > +{
> > > > +	struct device *dev;
> > > > +	int ret = 0;
> > > > +
> > > > +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> > > > +	if (!dev)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	dev->parent = &pdev->dev;
> > > > +	dev->release = err_dev_release;
> > > > +	dev_set_name(dev, "errors");
> > > > +
> > > > +	fme_error_enable(feature);
> > > > +
> > > > +	ret = device_register(dev);
> > > > +	if (ret) {
> > > > +		put_device(dev);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	ret = device_add_groups(dev, error_groups);
> > > 
> > > cute, but no, you do not create a whole struct device for a subdir.  Use
> > > the attribute group name like you did on earlier patches.
> > 
> > Sure, let me fix it in the next version.
> > 
> > > 
> > > And again, you raced userspace and lost :(
> > 
> > Same here, could you please give some more hints here?
> 
> Oh.. I see..
> 
> I should follow [1] as this is a platform driver. I will fix it. Thanks!
> 
> [PATCH 00/11] Platform drivers, provide a way to add sysfs groups easily
> 
> [1]https://lkml.org/lkml/2019/7/4/181

Yes, that is the correct thing to do.

thanks,

greg k-h
