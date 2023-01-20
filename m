Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C386749E4
	for <lists+linux-fpga@lfdr.de>; Fri, 20 Jan 2023 04:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjATDOX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 19 Jan 2023 22:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjATDOV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 19 Jan 2023 22:14:21 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19256581;
        Thu, 19 Jan 2023 19:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674184455; x=1705720455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7nuLpD4orZPHfVlQE967YTFDlkAAAVajeRbHSw/ZVyk=;
  b=eerCcgt/wHrxfkOU5Mdh27Y6BTbaPtCoOT5mGiayD2Rng0yQtzC5MbUR
   JXTLHzGLL/AOTXdzMc8SyIyFpFm/y+9Uv+J8IMYEE4hrhAuzZkl4/tmxE
   phjcn4/TaQQ18BnYUSWNJWUytwjHPPy2kZUYa2NqPeXTkhsFZXmWtnjV9
   /o6qkejqNXvpjx601D5dtQqP8SHf9lRV8vnMoFrw4eQf0zYrzLZ7Ae4ne
   QUDVUcOFiqP8PU/Fq/MjREczAHx3ze1qdpGVHve541cFkjqe/n0gguh4y
   65ar97JmnO4XI6772atEJ871ZFGdqppCJQF58+mDeHzDSj0DVsaoReL+z
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="305170151"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="305170151"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 19:14:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="768541533"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="768541533"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jan 2023 19:14:12 -0800
Date:   Fri, 20 Jan 2023 11:03:45 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-fpga@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/11] mfd: intel-m10-bmc: Add missing includes to
 header
Message-ID: <Y8oEka2u3TSNiWtw@yilunxu-OptiPlex-7050>
References: <20230116100845.6153-1-ilpo.jarvinen@linux.intel.com>
 <20230116100845.6153-2-ilpo.jarvinen@linux.intel.com>
 <1afecb9c-b17c-d2a5-d887-b7dced939586@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1afecb9c-b17c-d2a5-d887-b7dced939586@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-01-17 at 08:43:03 -0800, Russ Weight wrote:
> 
> 
> On 1/16/23 02:08, Ilpo Järvinen wrote:
> > linux/mfd/intel-m10-bmc.h is using:
> > 	- pr_err(), thus include also linux/dev_printk.h
> > 	- FIELD_GET(), this include also linux/bitfield.h
> > 	- GENMASK(), thus include also linux/bits.h
> 
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

> 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  include/linux/mfd/intel-m10-bmc.h | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> > index f0044b14136e..0d4db5d9d5af 100644
> > --- a/include/linux/mfd/intel-m10-bmc.h
> > +++ b/include/linux/mfd/intel-m10-bmc.h
> > @@ -7,6 +7,9 @@
> >  #ifndef __MFD_INTEL_M10_BMC_H
> >  #define __MFD_INTEL_M10_BMC_H
> >  
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/dev_printk.h>
> >  #include <linux/regmap.h>
> >  
> >  #define M10BMC_LEGACY_BUILD_VER		0x300468
> 
