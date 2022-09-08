Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089365B1ADD
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Sep 2022 13:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiIHLEZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 8 Sep 2022 07:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiIHLEW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 8 Sep 2022 07:04:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C6E138;
        Thu,  8 Sep 2022 04:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662635061; x=1694171061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fqkHwC0iOprBEufOeKlcg21ZbXtIUhGHzIz0tLHzfq8=;
  b=P5A11Smug85abEfoYrdeSWYKEViuicI7UnU0Cr0Wq2tBs/4DdY7cyXcu
   djZjon6WvvkWf8BDIe20s3BNBs9X8tV50IGLyEG9XwNu++pF68TLcEryk
   pH6Q/+HITs3PjIpnJ5dXB+3I28GBwHE5q3/w+CIDRl2AMwiiHsoo+ndwU
   pqeIdHtFVYbDuvLMaYDv7AfL6aqnGFEWoTlWCPwWISWW+8MnCwzFkGJcg
   Thlef21zmZ+5+aLOXYzRydArQD9OOdUb4woPPr9kuQ6mWzz3zhDeMyO6g
   G3kn/t4U+w7SZTZDUFecmsSXG9E+Fni1RCIV9hZRF2B+Znr3RTE4HqSRB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="361098738"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="361098738"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 04:04:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="740634993"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 04:04:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oWFKO-00A5Z7-2n;
        Thu, 08 Sep 2022 14:04:12 +0300
Date:   Thu, 8 Sep 2022 14:04:12 +0300
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
Message-ID: <YxnMLI17XvjN74DW@smile.fi.intel.com>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com>
 <20220906190426.3139760-5-matthew.gerlach@linux.intel.com>
 <YxeqTdny7Nu7LzZo@smile.fi.intel.com>
 <alpine.DEB.2.22.394.2209071433320.3336870@rhweight-WRK1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2209071433320.3336870@rhweight-WRK1>
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

On Wed, Sep 07, 2022 at 02:37:32PM -0700, matthew.gerlach@linux.intel.com wrote:
> On Tue, 6 Sep 2022, Andy Shevchenko wrote:
> > On Tue, Sep 06, 2022 at 12:04:25PM -0700, matthew.gerlach@linux.intel.com wrote:

...

> > > +	if (fid != FEATURE_ID_AFU && fid != PORT_FEATURE_ID_ERROR &&
> > > +	    fid != PORT_FEATURE_ID_UINT && fid != FME_FEATURE_ID_GLOBAL_ERR) {
> > > +		v = readq(base);
> > > +		v = FIELD_GET(DFH_VERSION, v);
> > > +
> > > +		if (v == 1) {
> > > +			v =  readq(base + DFHv1_CSR_SIZE_GRP);
> > 
> > I am already lost what v keeps...
> > 
> > Perhaps
> > 
> > 		v = readq(base);
> > 		switch (FIELD_GET(DFH_VERSION, v)) {
> > 		case 1:
> > 			...
> > 			break;
> > 		}
> 
> How about?
> 		if (FIELD_GET(DFH_VERSION, readq(base)) == 1) {
> 			...
> 		}

This one tends to be expanded in the future, so I would keep it switch case.

-- 
With Best Regards,
Andy Shevchenko


