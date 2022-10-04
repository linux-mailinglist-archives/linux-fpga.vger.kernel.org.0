Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA9E5F4608
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Oct 2022 16:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJDOzM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Oct 2022 10:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJDOzK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Oct 2022 10:55:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36261C41D;
        Tue,  4 Oct 2022 07:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664895309; x=1696431309;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ukW3DZ9qfunc0cxq05UBGyWkbgjuOQ47AszS9nmdg1s=;
  b=I/2wBLX7MnppNRCwmGrb3Xn+2wbfuD8ckVTLJG56yKeLd1lqROMXgPSA
   2nXRSN2D+bkUlRygV0+MJHEjREe4TvE25is5/sQMCKOK9IaAhSrObCrN4
   x/i7IZnVv0QTGE8Dp3AbTHJhlJ3IBCZR22OZFdPwZwsevJ2OaMP56oAOC
   +Xb3kr7xVqKA+FWhnacd9bGe9XWr5LdQPUdBfQDFuhpMyJoLkIvw/SpGE
   11Y3ZWJjfHBon6VWQU55jgz9YPjtZ9vPLRtX5OoxGy5hXBw8ywyNp36H6
   gCRurCtTS/C7iMCEMqbSKHQPhiWXfnrnZdlZt0aLLPK7nCJMtxgGz9uPM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="286119981"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="286119981"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 07:55:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="575050547"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="575050547"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 04 Oct 2022 07:55:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ofjK1-0027Uz-0y;
        Tue, 04 Oct 2022 17:55:01 +0300
Date:   Tue, 4 Oct 2022 17:55:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de,
        Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>
Subject: Re: [PATCH v3 2/4] fpga: dfl: Add DFHv1 Register Definitions
Message-ID: <YzxJRcdnvm1rWROK@smile.fi.intel.com>
References: <20221004143718.1076710-1-matthew.gerlach@linux.intel.com>
 <20221004143718.1076710-3-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004143718.1076710-3-matthew.gerlach@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Oct 04, 2022 at 07:37:16AM -0700, matthew.gerlach@linux.intel.com wrote:
> From: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
> 
> This patch adds the definitions for DFHv1 header and related register
> bitfields.

...

> - * Copyright (C) 2017-2018 Intel Corporation, Inc.
> + * Copyright (C) 2017-2022 Intel Corporation, Inc.

I do not think this is correct.

What happened to the code in 2019, 2020, and 2021? It's unclear. Have you
consulted with our lawyer about this?

That said, I _think_ (not your lawyer though) that the correct one should be

 * Copyright (C) 2017-2018,2022 Intel Corporation, Inc.

If you wanted to correct that, perhaps it should be done in a separate patch
first with explanation for those years in the gap. Unfortunately I haven't
found any description for those.

Ditto for the rest similar cases.

-- 
With Best Regards,
Andy Shevchenko


