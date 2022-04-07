Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFDC4F71F1
	for <lists+linux-fpga@lfdr.de>; Thu,  7 Apr 2022 04:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiDGCTA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 6 Apr 2022 22:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbiDGCS5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 6 Apr 2022 22:18:57 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5377F94C6;
        Wed,  6 Apr 2022 19:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649297818; x=1680833818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=llF4ThJA8WXHbpmx9IR7QlE6waiGypoC/axSTEFWsaU=;
  b=U1NkePxPQ8xO6B2xi3K/Mb6zofXd2B0gxKhi3GMCS/mx0Zaca7FyWL81
   v2O0IvNeVz2K9HRTkmEmbGbeDGPypV2J+7ei/zesjMo1oyncdLZsYg7fN
   l8aOk8WLinlKb1lIVQkzArN53/cRqPqbQkRlr3TWzUqn7QIj/qv6VqvSU
   tQ7hWNEwAmI4LD4w2yty2uzBE/I1MyoIj0B0D3y1xSjP39ujysMCRLila
   D4N+XFD7qjMP59DNx8UUjLQaRTRFkOUHWCuPQ45wJclZvbx046AhMfy7g
   xifkikx9k6gMUvyKNKvE3UhXqW/bar6L77I47sgH4hyTAWJZquRscfjSs
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="321901648"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="321901648"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 19:16:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="524183462"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga002.jf.intel.com with ESMTP; 06 Apr 2022 19:16:56 -0700
Date:   Thu, 7 Apr 2022 10:09:35 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: altera-pr-ip: fix unsigned comparison with less
  than zero
Message-ID: <20220407020935.GA256292@yilunxu-OptiPlex-7050>
References: <20220405185349.220607-1-marpagan@redhat.com>
 <d39cdc4c-0dc5-f929-17fa-ffbaf9e767c7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d39cdc4c-0dc5-f929-17fa-ffbaf9e767c7@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Apr 06, 2022 at 07:18:21AM -0700, Tom Rix wrote:
> 
> On 4/5/22 11:53 AM, Marco Pagani wrote:
> > Fix the "comparison with less than zero" warning reported by
> > cppcheck for the unsigned (size_t) parameter "count" of the
> > "alt_pr_fpga_write()" function.
> > 
> > Signed-off-by: Marco Pagani <marpagan@redhat.com>
> > ---
> >   drivers/fpga/altera-pr-ip-core.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
> > index be0667968d33..2ff3d8e46a0c 100644
> > --- a/drivers/fpga/altera-pr-ip-core.c
> > +++ b/drivers/fpga/altera-pr-ip-core.c
> > @@ -108,7 +108,7 @@ static int alt_pr_fpga_write(struct fpga_manager *mgr, const char *buf,
> >   	u32 *buffer_32 = (u32 *)buf;
> >   	size_t i = 0;
> > -	if (count <= 0)
> > +	if (count == 0)
> >   		return -EINVAL;
> 
> Reviewed-by: Tom Rix <trix@redhat.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

> 
> >   	/* Write out the complete 32-bit chunks */
