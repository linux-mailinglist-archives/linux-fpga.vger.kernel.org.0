Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897355AF59A
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Sep 2022 22:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiIFUO0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Sep 2022 16:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiIFUNs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Sep 2022 16:13:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8D317054;
        Tue,  6 Sep 2022 13:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662494975; x=1694030975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R5ziE4NZHKzhrlYILIrXK2TCsgbtzMrrhNljsAEwpTA=;
  b=YtcyhcEfqvm4cUDeKka4oz9qtWRp+iWkiKn8+J5voUg//YqDJJRoyj2g
   YDBjcFvjTrStXMiJKzFXJFIVgyjW18yPEizV3N7BOwFhdmGciTAfP6vkL
   eFXRMoSPqDsZOTkGNAZ6Wf+PtBnbf4T49AfNE2yd4aXUiLzgyRlENWPSF
   hKmGFvajTwRakQXrjwKZpcfSx0q13+jRFU7+kJ4EyHy3DK1O4gENNOVxx
   wtcoLDLXK0ByfzOnM1tlWg8iGnGIa28vPpeiGjiHNL97nXng+CSeEWm0i
   MNaDQdlXQKGbRwdVSOxPRixkVw/q1vrN9KAr6d9XXgNUEts/2fsJXRg00
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="294280049"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="294280049"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 13:08:39 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="675849907"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 13:08:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oVes3-009MGG-0J;
        Tue, 06 Sep 2022 23:08:31 +0300
Date:   Tue, 6 Sep 2022 23:08:30 +0300
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
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de
Subject: Re: [PATCH v1 1/5] Documentation: fpga: dfl: Add documentation for
 DFHv1
Message-ID: <YxeovjbDq1IP7PZk@smile.fi.intel.com>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com>
 <20220906190426.3139760-2-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906190426.3139760-2-matthew.gerlach@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Sep 06, 2022 at 12:04:22PM -0700, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add documentation describing the extentions provided by Version
> 1 of the Device Feature Header (DFHv1).

...

> +With DFHv0, not all features types contained a GUID.  DFHv1 makes the GUILD standard
> +across all types.

GUI_L_D?

-- 
With Best Regards,
Andy Shevchenko


