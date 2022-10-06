Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26B75F63EE
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Oct 2022 11:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiJFJ4L (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 6 Oct 2022 05:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiJFJ4K (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 6 Oct 2022 05:56:10 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671D382761;
        Thu,  6 Oct 2022 02:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665050165; x=1696586165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ped3EFOSYgP0u/JOGENQgHEAPb1CTPyVsTF/z2bnBqI=;
  b=L0NHfLuvLkCl1pVQ6S5hUSZA98zGNWlQCSOiIuhwBrK/I7g0NOsaIvHf
   wHxu3MyGQ0KReGyRupAdmhUW6T47Q2UYdY7U3pXZqwY3EDKqXBLWOdE3/
   Sk2Rit8pPO3srbjqjEIQQMaoYqQRwAdx33ex6ZN3ulI3IT9RY5BFnrLMR
   4jxknb0RgGG8DKiNbZfGgeRkWxy92enpwzP10qtckQYbCAnCYRHPtO5lO
   N5l/eruZfqBdixkxeA+Wgxop052SGJBPsJscwo+yGuV0FcZ6kbAIWyAYN
   kVcdD5ljijjzby0WZNcznbu9o7CN9AKE2t9x+ku5tuXneJQ/tLXYGwj2I
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="301000600"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="301000600"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 02:56:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="869785880"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="869785880"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga006.fm.intel.com with ESMTP; 06 Oct 2022 02:56:00 -0700
Date:   Thu, 6 Oct 2022 17:47:04 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     matthew.gerlach@linux.intel.com, hao.wu@intel.com,
        russell.h.weight@intel.com, basheer.ahmed.muddebihal@intel.com,
        trix@redhat.com, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de
Subject: Re: [PATCH v3 3/4] fpga: dfl: add basic support for DFHv1
Message-ID: <Yz6kGM0qvIF/E2Bp@yilunxu-OptiPlex-7050>
References: <20221004143718.1076710-1-matthew.gerlach@linux.intel.com>
 <20221004143718.1076710-4-matthew.gerlach@linux.intel.com>
 <YzxNCngIuzMqIOHe@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzxNCngIuzMqIOHe@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-10-04 at 18:11:06 +0300, Andy Shevchenko wrote:
> On Tue, Oct 04, 2022 at 07:37:17AM -0700, matthew.gerlach@linux.intel.com wrote:
> > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > 
> > Add generic support for MSIX interrupts for DFL devices.
> 

...

> 
> > +int dfhv1_find_param(void __iomem *base, resource_size_t max, int param)
> > +{
> > +	int off = DFHv1_PARAM_HDR;
> > +	u64 v, next;
> > +
> > +	while (off < max) {
> > +		v = readq(base + off);
> > +		if (param == FIELD_GET(DFHv1_PARAM_HDR_ID, v))
> 
> > +			return (DFHv1_PARAM_DATA + off);
> 
> Too many parentheses.
> 
> > +
> > +		next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, v);
> > +		if (!next)
> > +			break;
> > +
> > +		off += next;
> > +	}
> > +
> > +	return -ENOENT;
> > +}
> 
> The entire function seems a bit dangerous to me. You can ask for any max which
> covers (up to) 64-bit address space and then do MMIO by basically arbitrary
> address. How do you protect against wrong MMIO window here? (This is FPGA, so
> anything can be read from HW, i.o.w. it's _untrusted_ source of the data.)
> 
> Also, have you tested this with IOMMU enabled? How do they work together (if
> there is any collision at all between two?)

Yeah, again I don't think this API is good to be used across modules,
even if the parameters got checked. It requires too much details for
other domain developers.

How about:

  dfl_find_param(struct dfl_device *ddev, int param_id)

Thanks,
Yilun
