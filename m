Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A085AF597
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Sep 2022 22:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiIFUN3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Sep 2022 16:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiIFUNB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Sep 2022 16:13:01 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AE4BFE91;
        Tue,  6 Sep 2022 13:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662494901; x=1694030901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BtSUgyZI0HU1Ciu5kPkV1iRG3MhKpjlp45UBeg7Ubto=;
  b=UN4MlCwZaX5iWbehPmfGxDy41jQgVUUqunDFgJVf1dOOCLsE+v4gmBLK
   YpyAh5J/VygCCLmYquPpNexopvjclbWukC1OSxNG4aYOhwlbQpu5O/+29
   6sdcoJHzaWTpVtrYhztXHpG3ad9Fc1eEjjFF15kcKuFuXESVwVDlXxr3l
   n7NvZM0fhqN7+CkQoJpUJiOVXOI/glY5MJ+ExDpetZh17Cn+LdpepqVbl
   FShXwawUB/zCTwrahA7vv1iu33ty3ykxBXxE4X/Or0RS12kkZD0ajF5YS
   rrrianKO3YmVAPWMS3AuqD48VZWaA3L0/69+T3f7+wNWD/yLHpZvtJy2Q
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="358409679"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="358409679"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 13:07:27 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="614221316"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 13:07:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oVeqr-009MCy-3D;
        Tue, 06 Sep 2022 23:07:18 +0300
Date:   Tue, 6 Sep 2022 23:07:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de,
        Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>
Subject: Re: [PATCH v1 2/5] fpga: dfl: Move the DFH definitions
Message-ID: <YxeoddLVHki/WDUu@smile.fi.intel.com>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com>
 <20220906190426.3139760-3-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906190426.3139760-3-matthew.gerlach@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Sep 06, 2022 at 12:04:23PM -0700, matthew.gerlach@linux.intel.com wrote:
> From: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
> 
> Moving the DFH register offset and register definitions from
> drivers/fpga/dfl.h to include/linux/dfl.h.  These definitions

Single space?

> need to be accessed by dfl drivers that are outside of
> drivers/fpga.

...

> +#define DFH			0x0
> +#define GUID_L			0x8
> +#define GUID_H			0x10
> +#define NEXT_AFU		0x18

While at it, you may make them same width, like "0x08".

-- 
With Best Regards,
Andy Shevchenko


