Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57B9691BD7
	for <lists+linux-fpga@lfdr.de>; Fri, 10 Feb 2023 10:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjBJJp5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 10 Feb 2023 04:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjBJJp4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 10 Feb 2023 04:45:56 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF545BA46;
        Fri, 10 Feb 2023 01:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676022354; x=1707558354;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X9YgtVPeoeJvTKdKlDl5yGEwcm415Jn/v+s7y2COFNM=;
  b=FwEV6VPe60TnFVylOp78jndq7wvSeMIeMYZS4Ozp68kGT2Uap/Ha3tPo
   imQdCqIxpH4bKo7C2+UNFr3xLbvwx6pzZns8gkp+6cLsSL3RF2QzIncR1
   m3X2XhHlWxJxW/0UADiUnJagtvWF9NM6fC91NtAj8QWiKtyVoWuK+g0Ip
   fv44x9V0BJR82rA29Btj3telqV2N9dLCVe9EZ3l7BUD2t7EqWhOua58FW
   10pZxujcmXK7sZFR7AwSxqjl0AV5tllAZD293Fyzot6N0rzQpRyKnlQBj
   LK0eSzY3rYXVqTyyhkhbqfewdEot1zylgP5QOvSw754GMYgdq6Kznwo/r
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="318396091"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="318396091"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:45:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="669943376"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="669943376"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga007.fm.intel.com with ESMTP; 10 Feb 2023 01:45:51 -0800
Date:   Fri, 10 Feb 2023 17:35:05 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     "Manne, Nava kishore" <nava.kishore.manne@amd.com>
Cc:     Marco Pagani <marpagan@redhat.com>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fpga: mgr: Update the state to provide the exact error
 code
Message-ID: <Y+YPyY2m6JYQEiy/@yilunxu-OptiPlex-7050>
References: <20230207095915.169146-1-nava.kishore.manne@amd.com>
 <8d34bc43-deb4-4166-83ad-34561ee5ac33@redhat.com>
 <DM6PR12MB3993232B3EB5DE00CBC9B452CDD89@DM6PR12MB3993.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB3993232B3EB5DE00CBC9B452CDD89@DM6PR12MB3993.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-02-08 at 11:01:17 +0000, Manne, Nava kishore wrote:
> Hi Marco,
> 
> 	Thanks for providing the review comments.
> Please find my response inline below.
> 
> > -----Original Message-----
> > From: Marco Pagani <marpagan@redhat.com>
> > Sent: Wednesday, February 8, 2023 12:04 AM
> > To: Nava kishore Manne <nava.manne@xilinx.com>
> > Cc: Manne, Nava kishore <nava.kishore.manne@amd.com>;
> > mdf@kernel.org; hao.wu@intel.com; trix@redhat.com; yilun.xu@intel.com;
> > linux-fpga@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] fpga: mgr: Update the state to provide the exact error
> > code
> > 
> > 
> > On 2023-02-07 10:59, Nava kishore Manne wrote:
> > > From: Nava kishore Manne <nava.manne@xilinx.com>
> > >
> > > Up on fpga configuration failure, the existing sysfs state interface
> > > is just providing the generic error message rather than providing the
> > > exact error code. This patch extends sysfs state interface to provide
> > > the exact error received from the lower layer along with the existing
> > > generic error message.
> > >
> > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > ---
> > >  drivers/fpga/fpga-mgr.c       | 20 +++++++++++++++++++-
> > >  include/linux/fpga/fpga-mgr.h |  2 ++
> > >  2 files changed, 21 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c index
> > > 8efa67620e21..b2d74705a5a2 100644
> > > --- a/drivers/fpga/fpga-mgr.c
> > > +++ b/drivers/fpga/fpga-mgr.c
> > > @@ -61,12 +61,14 @@ static inline int fpga_mgr_write_complete(struct
> > > fpga_manager *mgr,  {
> > >  	int ret = 0;
> > >
> > > +	mgr->err = 0;
> > >  	mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE;
> > >  	if (mgr->mops->write_complete)
> > >  		ret = mgr->mops->write_complete(mgr, info);
> > >  	if (ret) {
> > >  		dev_err(&mgr->dev, "Error after writing image data to
> > FPGA\n");
> > >  		mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
> > > +		mgr->err = ret;
> > >  		return ret;
> > >  	}
> > >  	mgr->state = FPGA_MGR_STATE_OPERATING; @@ -154,6 +156,7 @@
> > static
> > > int fpga_mgr_parse_header_mapped(struct fpga_manager *mgr,  {
> > >  	int ret;
> > >
> > > +	mgr->err = 0;
> > >  	mgr->state = FPGA_MGR_STATE_PARSE_HEADER;
> > >  	ret = fpga_mgr_parse_header(mgr, info, buf, count);
> > >
> > > @@ -165,6 +168,7 @@ static int fpga_mgr_parse_header_mapped(struct
> > fpga_manager *mgr,
> > >  	if (ret) {
> > >  		dev_err(&mgr->dev, "Error while parsing FPGA image
> > header\n");
> > >  		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
> > > +		mgr->err = ret;
> > >  	}
> > >
> > >  	return ret;
> > > @@ -185,6 +189,7 @@ static int fpga_mgr_parse_header_sg_first(struct
> > fpga_manager *mgr,
> > >  	int ret;
> > >
> > >  	mgr->state = FPGA_MGR_STATE_PARSE_HEADER;
> > > +	mgr->err = 0;
> > >
> > >  	sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
> > >  	if (sg_miter_next(&miter) &&
> > > @@ -197,6 +202,7 @@ static int fpga_mgr_parse_header_sg_first(struct
> > fpga_manager *mgr,
> > >  	if (ret && ret != -EAGAIN) {
> > >  		dev_err(&mgr->dev, "Error while parsing FPGA image
> > header\n");
> > >  		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
> > > +		mgr->err = ret;
> > >  	}
> > >
> > >  	return ret;
> > > @@ -249,6 +255,7 @@ static void *fpga_mgr_parse_header_sg(struct
> > fpga_manager *mgr,
> > >  	if (ret) {
> > >  		dev_err(&mgr->dev, "Error while parsing FPGA image
> > header\n");
> > >  		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
> > > +		mgr->err = ret;
> > >  		kfree(buf);
> > >  		buf = ERR_PTR(ret);
> > >  	}
> > > @@ -272,6 +279,7 @@ static int fpga_mgr_write_init_buf(struct
> > fpga_manager *mgr,
> > >  	size_t header_size = info->header_size;
> > >  	int ret;
> > >
> > > +	mgr->err = 0;
> > >  	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
> > >
> > >  	if (header_size > count)
> > > @@ -284,6 +292,7 @@ static int fpga_mgr_write_init_buf(struct
> > fpga_manager *mgr,
> > >  	if (ret) {
> > >  		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
> > >  		mgr->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
> > > +		mgr->err = ret;
> > >  		return ret;
> > >  	}
> > >
> > > @@ -370,6 +379,7 @@ static int fpga_mgr_buf_load_sg(struct
> > > fpga_manager *mgr,
> > >
> > >  	/* Write the FPGA image to the FPGA. */
> > >  	mgr->state = FPGA_MGR_STATE_WRITE;
> > > +	mgr->err = 0;
> > >  	if (mgr->mops->write_sg) {
> > >  		ret = fpga_mgr_write_sg(mgr, sgt);
> > >  	} else {
> > > @@ -405,6 +415,7 @@ static int fpga_mgr_buf_load_sg(struct
> > fpga_manager *mgr,
> > >  	if (ret) {
> > >  		dev_err(&mgr->dev, "Error while writing image data to
> > FPGA\n");
> > >  		mgr->state = FPGA_MGR_STATE_WRITE_ERR;
> > > +		mgr->err = ret;
> > >  		return ret;
> > >  	}
> > >
> > > @@ -437,10 +448,12 @@ static int fpga_mgr_buf_load_mapped(struct
> > fpga_manager *mgr,
> > >  	 * Write the FPGA image to the FPGA.
> > >  	 */
> > >  	mgr->state = FPGA_MGR_STATE_WRITE;
> > > +	mgr->err = 0;
> > >  	ret = fpga_mgr_write(mgr, buf, count);
> > >  	if (ret) {
> > >  		dev_err(&mgr->dev, "Error while writing image data to
> > FPGA\n");
> > >  		mgr->state = FPGA_MGR_STATE_WRITE_ERR;
> > > +		mgr->err = ret;
> > >  		return ret;
> > >  	}
> > >
> > > @@ -544,10 +557,11 @@ static int fpga_mgr_firmware_load(struct
> > fpga_manager *mgr,
> > >  	dev_info(dev, "writing %s to %s\n", image_name, mgr->name);
> > >
> > >  	mgr->state = FPGA_MGR_STATE_FIRMWARE_REQ;
> > > -
> > > +	mgr->err = 0;
> > >  	ret = request_firmware(&fw, image_name, dev);
> > >  	if (ret) {
> > >  		mgr->state = FPGA_MGR_STATE_FIRMWARE_REQ_ERR;
> > > +		mgr->err = ret;
> > >  		dev_err(dev, "Error requesting firmware %s\n",
> > image_name);
> > >  		return ret;
> > >  	}
> > > @@ -626,6 +640,10 @@ static ssize_t state_show(struct device *dev,  {
> > >  	struct fpga_manager *mgr = to_fpga_manager(dev);
> > >
> > > +	if (mgr->err)
> > > +		return sprintf(buf, "%s: 0x%x\n",
> > > +			       state_str[mgr->state], mgr->err);
> > > +
> > >  	return sprintf(buf, "%s\n", state_str[mgr->state]);
> > 
> > 
> > If one of the fpga manager ops fails, the low-level error code is already
> > returned to the caller. Wouldn't it be better to rely on this instead of printing
> > the low-level error code in a sysfs attribute and sending it to the userspace?
> > 
> Agree, the low-level error code is already returned to the caller but the user application
> will not have any access to read this error info. So, I feel this patch provides that flexibility 
> to the user application to get the exact error info. 

Why a user application need to look into these driver implementation
details. If just for debug, there are many existing methods for a
developer to trace the code.

Thanks,
Yilun

> please let me know if you have any other thoughts will implement that.
> 
> Regards,
> Navakishore.
