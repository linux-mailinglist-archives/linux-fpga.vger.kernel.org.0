Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31D850DA50
	for <lists+linux-fpga@lfdr.de>; Mon, 25 Apr 2022 09:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbiDYHmq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Apr 2022 03:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240010AbiDYHmf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 25 Apr 2022 03:42:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5150F1EC65;
        Mon, 25 Apr 2022 00:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650872369; x=1682408369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3KF/nt6njR142ErCOrFh+78Qmc0uUlvrXI0T2lqSfgI=;
  b=anMJAV56slPzoLJLm8CV4apSUhYIkAWjSpqH+37f9mCU/xlNLzFYQ8Cd
   BagUvcKdtmsERH7hg6VeAtd0CC8azIavdVoVI3Hr73P/5IrUHGFGV4Iun
   OAjQT9cuKFgATku2IIFq0qqsIKBot9S49bTrEzYlPNJARRbQqanhb05hn
   pLFPP75ftDWwkriWvAgtts5SpAdnOES41GwslhmNE5btu7PwqoLSX1hoo
   OAWzrRUrYThjfbzg4Sqy49UNaWF4GGJDB0bGx12zw+YkUDsFkciv0Ft4L
   LRv0FhVkG7whq2Gna3CApYm1cPyvB7aZNmsCJbAW6VyNwLdAGu0v9gKOs
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="264971399"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="264971399"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 00:39:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="531988427"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga006.jf.intel.com with ESMTP; 25 Apr 2022 00:39:20 -0700
Date:   Mon, 25 Apr 2022 15:31:39 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Tianfei Zhang <tianfei.zhang@intel.com>, hao.wu@intel.com,
        trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v7 1/2] fpga: dfl: check feature type before parse irq
  info
Message-ID: <20220425073139.GC363795@yilunxu-OptiPlex-7050>
References: <20220419032942.427429-1-tianfei.zhang@intel.com>
 <20220419032942.427429-2-tianfei.zhang@intel.com>
 <YmFuPdzQCL5LwH2F@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmFuPdzQCL5LwH2F@archbook>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Apr 21, 2022 at 07:46:21AM -0700, Moritz Fischer wrote:
> On Mon, Apr 18, 2022 at 11:29:41PM -0400, Tianfei Zhang wrote:
> > From: Tianfei zhang <tianfei.zhang@intel.com>
> > 
> > Previously the feature IDs defined are unique, no matter
> > which feature type. But currently we want to extend its
> > usage to have a per-type feature ID space, so this patch
> > adds feature type checking as well just before look into
> > feature ID for different features which have irq info.
> > 
> > Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Acked-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Moritz Fischer <mdf@kernel.org>

Acked-by: Xu Yilun <yilun.xu@intel.com>

> > Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> > ---
> > v7:
> >   - Add Reviewed-by and Acked-by tag.
> > v4:
> >   - Fix the git commit from Hao's comments.
> >   - Split documentation into another patch.
> > v3:
> >   - Remove "Fixes" in commit log with Hao's comment, this is a
> >     extension not a bug fix.
> > v2:
> >   - add DFL Feature ID Registry in documentation.
> > ---
> >  drivers/fpga/dfl.c | 38 ++++++++++++++++++++++----------------
> >  1 file changed, 22 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > index 599bb21d86af..6bff39ff21a0 100644
> > --- a/drivers/fpga/dfl.c
> > +++ b/drivers/fpga/dfl.c
> > @@ -940,9 +940,12 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
> >  {
> >  	void __iomem *base = binfo->ioaddr + ofst;
> >  	unsigned int i, ibase, inr = 0;
> > +	enum dfl_id_type type;
> >  	int virq;
> >  	u64 v;
> >  
> > +	type = feature_dev_id_type(binfo->feature_dev);
> > +
> >  	/*
> >  	 * Ideally DFL framework should only read info from DFL header, but
> >  	 * current version DFL only provides mmio resources information for
> > @@ -957,22 +960,25 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
> >  	 * code will be added. But in order to be compatible to old version
> >  	 * DFL, the driver may still fall back to these quirks.
> >  	 */
> > -	switch (fid) {
> > -	case PORT_FEATURE_ID_UINT:
> > -		v = readq(base + PORT_UINT_CAP);
> > -		ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> > -		inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> > -		break;
> > -	case PORT_FEATURE_ID_ERROR:
> > -		v = readq(base + PORT_ERROR_CAP);
> > -		ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> > -		inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> > -		break;
> > -	case FME_FEATURE_ID_GLOBAL_ERR:
> > -		v = readq(base + FME_ERROR_CAP);
> > -		ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> > -		inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> > -		break;
> > +	if (type == PORT_ID) {
> > +		switch (fid) {
> > +		case PORT_FEATURE_ID_UINT:
> > +			v = readq(base + PORT_UINT_CAP);
> > +			ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> > +			inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> > +			break;
> > +		case PORT_FEATURE_ID_ERROR:
> > +			v = readq(base + PORT_ERROR_CAP);
> > +			ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> > +			inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> > +			break;
> > +		}
> > +	} else if (type == FME_ID) {
> > +		if (fid == FME_FEATURE_ID_GLOBAL_ERR) {
> > +			v = readq(base + FME_ERROR_CAP);
> > +			ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> > +			inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> > +		}
> >  	}
> >  
> >  	if (!inr) {
> > -- 
> > 2.26.2
> > 
