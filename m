Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1455B2531
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Sep 2022 19:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiIHRvu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 8 Sep 2022 13:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiIHRvt (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 8 Sep 2022 13:51:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D96C7B9A;
        Thu,  8 Sep 2022 10:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662659508; x=1694195508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iITsaejue4VmR3y8fcrz/QdH7Lo9YAg9dPOM9vd6m0c=;
  b=cSRtHBALfZzlX0Ebe4QXX34Moll8IHH4hULoXa6R+LUGgh2lUSDP5/UG
   gXB7XDkjLTeHMh2RQQ/6R16GdkFiGYXBr3bcnHWmSQGFtLprbEdw3bYud
   bR35lEw0zc9wvojFVSAtrGIaXez9T/GEVlWmDkN5QrEGcNCuVMvl7yIdY
   Yzwz0a9sswtxi9MAWRlwjO2V9rEXW7HC6o6oA6coHhoEc9v5S60An2xG2
   FVc6q8MQQaeteikPWhOEIR0ng43LfaspenMSnpyv14Q83liJO1aONEIwW
   Kp3L7dl3VrzfDZmyUGWBrpVoIL7j8luxyr653wVUbWJMvEprWz6y9yw3B
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="361237067"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="361237067"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 10:51:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="757300201"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 10:51:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oWLgO-00ADxr-2s;
        Thu, 08 Sep 2022 20:51:20 +0300
Date:   Thu, 8 Sep 2022 20:51:20 +0300
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
Subject: Re: [PATCH v1 4/5] fpga: dfl: add generic support for MSIX interrupts
Message-ID: <YxormF55DRW6oGgN@smile.fi.intel.com>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com>
 <20220906190426.3139760-5-matthew.gerlach@linux.intel.com>
 <YxeqTdny7Nu7LzZo@smile.fi.intel.com>
 <alpine.DEB.2.22.394.2209071433320.3336870@rhweight-WRK1>
 <YxnMLI17XvjN74DW@smile.fi.intel.com>
 <alpine.DEB.2.22.394.2209081031450.61321@rhweight-WRK1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2209081031450.61321@rhweight-WRK1>
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

On Thu, Sep 08, 2022 at 10:34:07AM -0700, matthew.gerlach@linux.intel.com wrote:
> On Thu, 8 Sep 2022, Andy Shevchenko wrote:
> > On Wed, Sep 07, 2022 at 02:37:32PM -0700, matthew.gerlach@linux.intel.com wrote:

...

> > This one tends to be expanded in the future, so I would keep it switch case.
> 
> I'm okay with using the switch statement, but how about the following?
> 
> 		switch (FIELD_GET(DFH_VERSION, readq(base))) {
>                 case 1:
> 			...
> 			break;
> 		}

Fine to me.

-- 
With Best Regards,
Andy Shevchenko


