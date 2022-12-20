Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E55652568
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Dec 2022 18:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiLTRPD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 20 Dec 2022 12:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiLTROm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 20 Dec 2022 12:14:42 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE283E4F;
        Tue, 20 Dec 2022 09:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671556470; x=1703092470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9d1nJaAzSfJTMXVymi/H0f1f3ZOMiYblofLgN80VI2Y=;
  b=kZ2uRO1Ijw7zVrxG1za+CMINZHxhmW25l/sU1D9f9FrpOtqUATkWly1w
   pw2C30G9N0ZiJd6baSgNBIl5c0h7czddLbKpnHh07eN42zgwItY64bK0H
   NopmKlxixpHKFtKYhbAZk5F5+hNuP1SZm4eLiaXGjfp9C4WQIvf4VDPn5
   Txc56VRJw/USCIPhRE33C4bqL5VmbMy42HDx3PP6kYXp97oPshsHLRqtT
   EYpyJL/LgPOj4aDGTpGuNF1vVrss8xBkKpXDnf9A0I3vP+RqoLQV+C3V6
   UpPDnS9K05bt0vxVP2BR8fV4r3sb71VfFm3yC83iZjGR4qbx7MF/tK9ye
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="299337927"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="299337927"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 09:09:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="775401914"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="775401914"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 20 Dec 2022 09:09:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p7g7E-00D1Kc-1b;
        Tue, 20 Dec 2022 19:09:20 +0200
Date:   Tue, 20 Dec 2022 19:09:20 +0200
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
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com, bagasdotme@gmail.com
Subject: Re: [PATCH v7 4/4] tty: serial: 8250: add DFL bus driver for Altera
 16550.
Message-ID: <Y6HsQJQMDnHgTesF@smile.fi.intel.com>
References: <20221220163652.499831-1-matthew.gerlach@linux.intel.com>
 <20221220163652.499831-5-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220163652.499831-5-matthew.gerlach@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Dec 20, 2022 at 08:36:52AM -0800, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add a Device Feature List (DFL) bus driver for the Altera
> 16550 implementation of UART.

In general the code here looks good to me, but one thing to discuss due to
comment to the previous patch(es).

...

> +	u64 *p;
> +
> +	p = dfh_find_param(dfl_dev, DFHv1_PARAM_ID_CLK_FRQ);
> +	if (!p)
> +		return dev_err_probe(dev, -EINVAL, "missing CLK_FRQ param\n");
> +
> +	p++;
> +	uart->port.uartclk = *p;

So, here and the below is using always the second u64 from the returned data.
Does it mean:
- we always skip the first u64 from the returned buffer and hence... (see below)
- we may actually return the second u64 as a plain number (not a pointer) from
  (an additional?) API? In such case we would not need to take care about this
  p++; lines here and there.
- we have fixed length of the data, returned by find_param(), i.e. 2 u64 words?

-- 
With Best Regards,
Andy Shevchenko


