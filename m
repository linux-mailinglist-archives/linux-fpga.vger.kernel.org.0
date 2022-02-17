Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1C34B9617
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Feb 2022 03:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiBQCrS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 16 Feb 2022 21:47:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiBQCrR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 16 Feb 2022 21:47:17 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C731FFC8E;
        Wed, 16 Feb 2022 18:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645066024; x=1676602024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QSnSOxdDtObgqzE/ltifayE1DCxwz1VCxKc2xdK3BnQ=;
  b=iLUKKwqyOfbqw+wVLqKkAXgMews9dyh47MjeTZ6KVmpp75ILA9p+qHhU
   eubs3/8EUdOQ34x5giGe0RAr1xHEbgCsZW9V1pfkjiXRd25whignlWtXg
   +R2sDq9DIwh6su3/YGAZ3WJuV7vzhPiJdv2voITp7KgGRIO0P+iGaM1v1
   BUzFI+BdBxFYGMwRguEzSam6OHTzyGjFBYAm+SBm5GYDmoX4+nu+cpE97
   bpdjYayBinwRbCgdJzvE3/GMu5jMo1Xz0G/WY5/2C2Tebmr08yL8VpO41
   Ne2610ibnXgDQcEFShZhal8a12AKcQEpIdQCmMo5froNr41vyAGGHpDBi
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="231399148"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="231399148"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 18:46:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="545307562"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.68])
  by orsmga008.jf.intel.com with ESMTP; 16 Feb 2022 18:46:46 -0800
Date:   Thu, 17 Feb 2022 10:38:16 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     Tianfei zhang <tianfei.zhang@intel.com>, hao.wu@intel.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net
Subject: Re: [PATCH v1 2/7] fpga: dfl: check feature type before parse irq
  info
Message-ID: <20220217023816.GD1145049@yilunxu-OptiPlex-7050>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-3-tianfei.zhang@intel.com>
 <0de9c8fb-0f04-684f-630c-1d13b0b55ba1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0de9c8fb-0f04-684f-630c-1d13b0b55ba1@redhat.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Feb 15, 2022 at 06:49:05AM -0800, Tom Rix wrote:
> 
> On 2/14/22 3:26 AM, Tianfei zhang wrote:
> > From: Tianfei Zhang <tianfei.zhang@intel.com>
> > 
> > The feature ID of "Port User Interrupt" and the
> > "PMCI Subsystem" are identical, 0x12, but one is for FME,
> > other is for Port. It should check the feature type While
> > parsing the irq info in parse_feature_irqs().
> 
> This seems like a bug fix and not part of iofs feature.
> 
> Split this out of the patchset.
> 
> This is a workaround a hardware problem, there should be some comments to
> the effect that you can't trust _this_ or _that_ feature id and some special
> handling earlier.
> 
> The ambiguity of feature id is a problem, and this sort of bug will happen

Actually this is not the feature id definition problem. The identity of the
feature is determined by the dfl_id_type(FME, PORT) AND feature_id. So the
driver should match the dfl_id_type & feature_id to know what feature it
is.

Thanks,
Yilun

> again.
> 
> What can be done to prevent this in the future ?
> 
> > 
> > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > ---
> >   drivers/fpga/dfl.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > index 599bb21d86af..26f8cf890700 100644
> > --- a/drivers/fpga/dfl.c
> > +++ b/drivers/fpga/dfl.c
> > @@ -940,9 +940,14 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
> >   {
> >   	void __iomem *base = binfo->ioaddr + ofst;
> >   	unsigned int i, ibase, inr = 0;
> > +	enum dfl_id_type type;
> >   	int virq;
> >   	u64 v;
> > +	type = feature_dev_id_type(binfo->feature_dev);
> > +	if (type >= DFL_ID_MAX)
> > +		return -EINVAL;
> > +
> >   	/*
> >   	 * Ideally DFL framework should only read info from DFL header, but
> >   	 * current version DFL only provides mmio resources information for
> > @@ -959,16 +964,22 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
> >   	 */
> >   	switch (fid) {
> >   	case PORT_FEATURE_ID_UINT:
> > +		if (type != PORT_ID)
> > +			break;
> 
> Instead of embedding a break in the switch, break the switch into fme switch
> and port switch
> 
> if (type == PORT_ID)
> 
>   port-switch
> 
> else if (type == FME_ID
> 
>   fme-switch
> 
> Tom
> 
> >   		v = readq(base + PORT_UINT_CAP);
> >   		ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> >   		inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> >   		break;
> >   	case PORT_FEATURE_ID_ERROR:
> > +		if (type != PORT_ID)
> > +			break;
> >   		v = readq(base + PORT_ERROR_CAP);
> >   		ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> >   		inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> >   		break;
> >   	case FME_FEATURE_ID_GLOBAL_ERR:
> > +		if (type != FME_ID)
> > +			break;
> >   		v = readq(base + FME_ERROR_CAP);
> >   		ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> >   		inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
