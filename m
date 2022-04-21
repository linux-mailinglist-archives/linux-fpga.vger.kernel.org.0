Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D41050A4F7
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Apr 2022 18:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiDUQGD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 21 Apr 2022 12:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354585AbiDUQGD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 21 Apr 2022 12:06:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51464839B;
        Thu, 21 Apr 2022 09:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650556992; x=1682092992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jRkl3afZKE4xraz15dRqZSIM82vN/xRL4/1OSG77U2I=;
  b=m9tW2F0/YSHeznULk0jKWECPnG2aqec3uFMrEzHbqejkwy9Km2STeMM6
   IiTQtU5kSY9sUPYQFBxC4WQvlTKaf+Srwn4CfQd+gUBlZ72PZR4NCsVXZ
   5qJIONMg/AEouOciDq4Gre0SImM90mo5l1iWgm/pTwEJsAq059Vk/9RTo
   Ui49zkoxKjSkaGY98U2XpvI0/MqAC31XkyjE+lgLwy6Jmf3ga0xsEwc/Y
   LBnyq06N/tO4R9aMJONh0q9rTC40z8vdavb75k9BiJIX7OI6InHJUBqIX
   rzZbpcf+Zg8YO8T1pjdEnQtKxyIZfkm/V6Wh/BcwAV0StpwO12T6j8Uuw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="244326476"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="244326476"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 09:03:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="703145798"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2022 09:03:10 -0700
Date:   Thu, 21 Apr 2022 23:55:33 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Nava kishore Manne <nava.manne@xilinx.com>, hao.wu@intel.com,
        trix@redhat.com, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@xilinx.com
Subject: Re: [PATCH v5 0/5]fpga: fix for coding style and kernel-doc issues
Message-ID: <20220421155533.GC347460@yilunxu-OptiPlex-7050>
References: <20220421044744.3777983-1-nava.manne@xilinx.com>
 <YmFpciblvR9xnjFX@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmFpciblvR9xnjFX@archbook>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Apr 21, 2022 at 07:25:54AM -0700, Moritz Fischer wrote:
> On Thu, Apr 21, 2022 at 10:17:39AM +0530, Nava kishore Manne wrote:
> > This patch series fixes the coding style and kernel-doc issues
> > exists in the fpga framework, zynq and ZynqMP drivers.
> > 
> > Nava kishore Manne (5):
> >   fpga: zynq: Fix incorrect variable type
> >   fpga: fix for coding style issues
> >   fpga: fpga-mgr: fix kernel-doc warnings
> >   fpga: Use tab instead of space indentation
> >   fpga: fpga-region: fix kernel-doc formatting issues
> > 
> >  drivers/fpga/Makefile            |  6 +++---
> >  drivers/fpga/fpga-mgr.c          |  8 ++++++--
> >  drivers/fpga/fpga-region.c       |  7 ++++---
> >  drivers/fpga/of-fpga-region.c    | 22 ++++++++++++----------
> >  drivers/fpga/zynq-fpga.c         |  2 +-
> >  include/linux/fpga/fpga-region.h |  7 ++++---
> >  6 files changed, 30 insertions(+), 22 deletions(-)
> > 
> > -- 
> > 2.25.1
> > 
> I've applied patches 1-4 to for-next.
> 
> Patch 5 seems to not apply.

Hi Moritz:

Seems some patches still need rework, is it possible we drop them
and wait for next version?

Thanks,
Yilun

> 
> - Moritz
