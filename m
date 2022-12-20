Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9957652507
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Dec 2022 17:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiLTQyN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 20 Dec 2022 11:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLTQyM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 20 Dec 2022 11:54:12 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863451C126;
        Tue, 20 Dec 2022 08:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671555251; x=1703091251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FhCPh5sFiyU9fY5zUT786lsvMOp/p0fAPDJfurRO1ao=;
  b=ZE6WyBsVC6CU5dw8ekp8FOCh/0OmG3KOlK0VDwPu3Z7A2Xzm83yHS02M
   y4jAzGHkTtC37GwSBlp3YNwxKjQQVIAwpLgv9/xFUoiIs4aBJZwjiORMT
   9a7DQkonvxixGCpHJsBldHAlzHWHpAVkVEg1upRicpxn/pgIrbcRJeoNu
   ECrpfUjNwke8PS2KjOUW8BbOx0BRSRYqQ4XrWeyxk5FPYseTGQIgp1yL8
   YeqayRIlNLKNGh0PqITpBGsRRxwYFkdmWsIZSilr0BNsBFN+/phXNZcrV
   92XkIYDRIZN3G+YU1nGPRQZF/vS9gJ1gavoEQ4Z7IFWtZO2TGTUIyCDTz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="318353707"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="318353707"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 08:54:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="601165478"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="601165478"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 20 Dec 2022 08:54:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p7fsN-00D0qK-2K;
        Tue, 20 Dec 2022 18:53:59 +0200
Date:   Tue, 20 Dec 2022 18:53:59 +0200
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
Subject: Re: [PATCH v7 1/4] Documentation: fpga: dfl: Add documentation for
 DFHv1
Message-ID: <Y6Hop0WhtOWRWg3t@smile.fi.intel.com>
References: <20221220163652.499831-1-matthew.gerlach@linux.intel.com>
 <20221220163652.499831-2-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220163652.499831-2-matthew.gerlach@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Dec 20, 2022 at 08:36:49AM -0800, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add documentation describing the extensions provided by Version
> 1 of the Device Feature Header (DFHv1).

...

> +Device Feature Header - Version 0
> +===========================================

Shouldn't this be the same length as the title itself?
Have you run make htmldocs and kernel doc validator on
this file after your change? Also you can use rst2pdf
to see PDF rendering.

Same to the other title.

-- 
With Best Regards,
Andy Shevchenko


