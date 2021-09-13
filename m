Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673F440871E
	for <lists+linux-fpga@lfdr.de>; Mon, 13 Sep 2021 10:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238216AbhIMIhp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 13 Sep 2021 04:37:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:27422 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238804AbhIMIfw (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 13 Sep 2021 04:35:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10105"; a="221659715"
X-IronPort-AV: E=Sophos;i="5.85,288,1624345200"; 
   d="scan'208";a="221659715"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 01:33:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,288,1624345200"; 
   d="scan'208";a="543061649"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Sep 2021 01:33:39 -0700
Date:   Mon, 13 Sep 2021 16:27:06 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v15 5/6] fpga: image-load: create status sysfs node
Message-ID: <20210913082706.GB773070@yilunxu-OptiPlex-7050>
References: <20210909021846.681121-1-russell.h.weight@intel.com>
 <20210909021846.681121-6-russell.h.weight@intel.com>
 <20210910085238.GD754505@yilunxu-OptiPlex-7050>
 <bc14ba58-a457-68dc-ca59-720adaa32524@intel.com>
 <ae637d01-b6c1-4b7f-a536-449e27c7711d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae637d01-b6c1-4b7f-a536-449e27c7711d@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Sep 11, 2021 at 10:58:16AM -0700, Tom Rix wrote:
> 
> On 9/10/21 4:30 PM, Russ Weight wrote:
> > 
> > On 9/10/21 1:52 AM, Xu Yilun wrote:
> > > On Wed, Sep 08, 2021 at 07:18:45PM -0700, Russ Weight wrote:
> > > > Extend the FPGA Image Load class driver to include a status sysfs node that
> > > > can be viewed to determine from the command line if an image load is in
> > > > progress. Status will be one of: idle, starting, preparing, writing, or
> > > > programming.
> > > The FPGA_IMAGE_LOAD_STATUS ioctl already provides the progress info.
> > > Why we need 2 user interfaces for the same information?
> > Updates on Vista Creek can take up to 40 minutes. I thought it might
> > be helpful to have a simple way, from the command line, to verify
> > whether or not there is an image upload in progress. Do you agree? Or
> > do you think this is unnecessary? Should I remove it? Or save it for
> > a later patch (after the main patches have been accepted)?
> 
> I agree, there should not be two methods to doing the same thing.
> 
> I prefer the ioctl since it handles other cmd's as well.
> 
> The user has to use the ioctl to start the write so it would for more
> natural to use the ioctl over sysfs to the check the status
> 
> Remove it.
> 
> Make a strong case for it's need when/if you want to add it back later.

Yes, remove it. Not a strong use case for this interface now.

Thanks,
Yilun
