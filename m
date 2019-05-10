Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33EE1196C0
	for <lists+linux-fpga@lfdr.de>; Fri, 10 May 2019 04:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfEJCjz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 9 May 2019 22:39:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:22061 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfEJCjz (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 9 May 2019 22:39:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 May 2019 19:39:54 -0700
X-ExtLoop1: 1
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by orsmga008.jf.intel.com with ESMTP; 09 May 2019 19:39:52 -0700
Date:   Fri, 10 May 2019 10:23:29 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Alan Tull <atull@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Luwei Kang <luwei.kang@intel.com>,
        Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v2 17/18] fpga: dfl: fme: add global error reporting
 support
Message-ID: <20190510022329.GA12617@hao-dev>
References: <1556528151-17221-1-git-send-email-hao.wu@intel.com>
 <1556528151-17221-18-git-send-email-hao.wu@intel.com>
 <CANk1AXRpBe=8Jh+_ZMfARSdXZmrQaN3jc0AfxoX2nP5sLESv2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXRpBe=8Jh+_ZMfARSdXZmrQaN3jc0AfxoX2nP5sLESv2A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, May 09, 2019 at 11:27:36AM -0500, Alan Tull wrote:
> On Mon, Apr 29, 2019 at 4:13 AM Wu Hao <hao.wu@intel.com> wrote:
> 
> Hi Hao,
> 
> The changes look good.  There's one easy to fix thing that Greg has
> pointed out recently on another patch (below).
> 
> >
> > This patch adds support for global error reporting for FPGA
> > Management Engine (FME), it introduces sysfs interfaces to
> > report different error detected by the hardware, and allow
> > user to clear errors or inject error for testing purpose.
> >
> > Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> > Signed-off-by: Ananda Ravuri <ananda.ravuri@intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> 
> Acked-by: Alan Tull <atull@kernel.org>
> 
> > ---
> > v2: fix issues found in sysfs doc.
> >     fix returned error code issues for writable sysfs interfaces.
> >     (use -EINVAL if input doesn't match error code)
> >     reorder the sysfs groups in code.
> 
> > +static ssize_t revision_show(struct device *dev, struct device_attribute *attr,
> > +                            char *buf)
> > +{
> > +       struct device *err_dev = dev->parent;
> > +       void __iomem *base;
> > +
> > +       base = dfl_get_feature_ioaddr_by_id(err_dev, FME_FEATURE_ID_GLOBAL_ERR);
> > +
> > +       return scnprintf(buf, PAGE_SIZE, "%u\n", dfl_feature_revision(base));
> 
> Greg is discouraging use of scnprintf for sysfs attributes where it's
> not needed [1].
> 
> Please fix this up the attributes added in this patchset.  Besides
> that, looks good, I added my Ack.

Sure, will fix them in the next patchset.

thanks a lot!

Hao

> 
> Alan
> 
> > +}
> > +static DEVICE_ATTR_RO(revision);
> 
> [1] https://lkml.org/lkml/2019/4/25/1050
