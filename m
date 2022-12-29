Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079D46591C2
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Dec 2022 21:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbiL2Uo4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Dec 2022 15:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiL2UoF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 29 Dec 2022 15:44:05 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104F6192BE;
        Thu, 29 Dec 2022 12:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672346481; x=1703882481;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8nFJfj1L6ajQNAz63881lx/5UMY+BMa5JW/kyHbHarg=;
  b=GXETx/eOQ6wJQKFq8g8SPyslTtREOI3zGXXH+OO0OH0DbaYtDsX805PS
   7sulWRPOSDE7BWDFodDcI0LYhH/hDlSFSqsn4O7iHVCkJ05fjGcHbQX2e
   vrDwCBOnapOtGYhY/0QZVtpNfISs8AJ60hNG2iQ5xXKCWO4nt9dZX9XsD
   pywvIcj5XGjSERekM6G63FG2Oo8WkOBnnVC+Jw6k68FXrqj64pCSnxD3t
   MEp6i/IniP21dJjpC75+a+0A4IoVxOAiq3bHD7+aX0DH184oY69sDspcr
   gObzAjwUTSxlLzCcwFhDtYm0TA/FfRi/tMLSnnArJC6jnzTA/+owyg5sm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="300801858"
X-IronPort-AV: E=Sophos;i="5.96,285,1665471600"; 
   d="scan'208";a="300801858"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 12:41:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="716996496"
X-IronPort-AV: E=Sophos;i="5.96,285,1665471600"; 
   d="scan'208";a="716996496"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 29 Dec 2022 12:41:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pAziD-001Kfc-0V;
        Thu, 29 Dec 2022 22:41:13 +0200
Date:   Thu, 29 Dec 2022 22:41:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     matthew.gerlach@linux.intel.com, hao.wu@intel.com,
        yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianfei.zhang@intel.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        linux-serial@vger.kernel.org, jirislaby@kernel.org,
        geert+renesas@glider.be, niklas.soderlund+renesas@ragnatech.se,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de,
        ilpo.jarvinen@linux.intel.com, marpagan@redhat.com,
        bagasdotme@gmail.com
Subject: Re: [PATCH v8 3/4] fpga: dfl: add basic support for DFHv1
Message-ID: <Y637aBTrbRloUtvD@smile.fi.intel.com>
References: <20221228181624.1793433-1-matthew.gerlach@linux.intel.com>
 <20221228181624.1793433-4-matthew.gerlach@linux.intel.com>
 <628c125a-5a84-e1bd-7724-2637315cc35e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <628c125a-5a84-e1bd-7724-2637315cc35e@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Dec 29, 2022 at 08:18:03AM -0800, Tom Rix wrote:
> On 12/28/22 10:16 AM, matthew.gerlach@linux.intel.com wrote:

...

> >   struct dfl_feature_info {
> >   	u16 fid;
> >   	u8 revision;
> > +	u8 dfh_version;
> >   	struct resource mmio_res;
> >   	void __iomem *ioaddr;
> >   	struct list_head node;
> >   	unsigned int irq_base;
> >   	unsigned int nr_irqs;
> > +	unsigned int param_size;
> > +	u64 params[];
> u64 *params

This will break the overflow.h macros, no?
Besides that it will break the code for sure as it's not an equivalent.

> >   };


-- 
With Best Regards,
Andy Shevchenko


