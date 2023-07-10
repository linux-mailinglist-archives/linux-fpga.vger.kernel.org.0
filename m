Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A907E74CF77
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Jul 2023 10:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjGJIHA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Jul 2023 04:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjGJIHA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 Jul 2023 04:07:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE61BB;
        Mon, 10 Jul 2023 01:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688976419; x=1720512419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NfXjdyeWvqp6EgsEFX6ytGwQlHh07tslExxu7PMVbis=;
  b=R8qWr8ETO+wyib5h6LulcCEZdmgpW4T8zKfuLVTo/0bFRuyslYu0NuJ0
   MvJJObSsvNQAnSE0qLA3af78XV2bnWqUvt/bhDTkwFy9vJn7aMjItx5mH
   nW3+uJhlznhv74R6uKD4NHVhZUmmWTwzDHf6TysJN/ojCXNAOb5BjUj5f
   QAKgD4DBw8gidtxQILH6OWVBiO0o+2A/dlurrZthaFDuKSAJqYYM1Om28
   IY3WUt+KbVi6bAe4VEumJqosGLeV/dFAc7y+rOpiee67STaKO4Pn7RiVY
   evdY+9WOK9wXY91NpN61+SwKpJL6s8B7UxeQ5Alr8i1yoVnX2pm+gjNGz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="450640722"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="450640722"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 01:06:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="723921249"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="723921249"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jul 2023 01:06:57 -0700
Date:   Mon, 10 Jul 2023 16:05:30 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>, marpagan@redhat.com
Cc:     Marco Pagani <marpagan@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] fpga: region: fix kernel-doc
Message-ID: <ZKu7yj1+QumQ9DlM@yilunxu-OptiPlex-7050>
References: <20230706142755.124879-1-marpagan@redhat.com>
 <20230706142755.124879-2-marpagan@redhat.com>
 <e5dae9f1-8492-3046-f694-80d13c9927e9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5dae9f1-8492-3046-f694-80d13c9927e9@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-07-06 at 14:30:34 -0700, Randy Dunlap wrote:
> Hi--
> 
> On 7/6/23 07:27, Marco Pagani wrote:
> > - Fix the following warnings issued by the kernel-doc script:
> > 
> > drivers/fpga/fpga-region.c:46: warning: No description found for return value of 'fpga_region_get'
> > drivers/fpga/fpga-region.c:97: warning: No description found for return value of 'fpga_region_program_fpga'
> > drivers/fpga/fpga-region.c:295: warning: No description found for return value of 'fpga_region_init'
> > 
> > - Remove the "and registers a reconfig notifier" part from the description
> >   of fpga_region_init() since it does not register an of_overlay notifier
> >   anymore.
> > 
> > - Remove the outdated "if @np is not an FPGA Region" case from the return
> >   description of fpga_region_get() and replace it with the case when
> >   try_module_get() fails.
> > 
> > Signed-off-by: Marco Pagani <marpagan@redhat.com>
> 
> Looks good. Thanks.
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied.

BTW: No need to have RFC if you think it is ready for full review.
