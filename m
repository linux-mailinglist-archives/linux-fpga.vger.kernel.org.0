Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E7A642573
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Dec 2022 10:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiLEJIR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Dec 2022 04:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiLEJHf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Dec 2022 04:07:35 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F246895A3;
        Mon,  5 Dec 2022 01:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670231160; x=1701767160;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=nEVmTCsQ6Xvwdl30ai/FZhUTkqBy3rpnK1gMd0qq5io=;
  b=aWM2V9jVCU6RsCqgv2Lyrq/x/e4xKgNVflwRzBHDljbUFHaWpiQxrGkL
   BkM/RKT+7awC7CYH6D9bfnFaXwHn/QT2kzSiF/gXNncil3aGlnMv+V6A7
   PodkxYK0mvlNhngvdK44uSiqZx3Cxll3noBpfukkrPYk3KFYK1Tzdy5jW
   jVkI6uPGhVthXsxzAp4hrb6qaJGMFnUoM5oLCdELfmBJ+jpI1bJX4kDb3
   1jDYWeKBccSYC/PmJB7Bd8OL4pcELythx9xTvLYnFIhiSGBEXDHMUhm2o
   8yOEclTdYJFRjsAP93B8tLLYQx3jlmQ0udZ//o9B28uYzmRlQ1y/OeKnA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="303918440"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="303918440"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 01:06:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="596132987"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="596132987"
Received: from andreial-mobl.ger.corp.intel.com ([10.251.213.105])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 01:05:56 -0800
Date:   Mon, 5 Dec 2022 11:05:44 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 9/9] mfd: intel-m10-bmc: Change MODULE_LICENSE() to
 GPL
In-Reply-To: <Y4xr+nmx7m66+KsL@kroah.com>
Message-ID: <2f692caa-bbf3-b5c6-ce11-af8148f1293c@linux.intel.com>
References: <20221202100841.4741-1-ilpo.jarvinen@linux.intel.com> <20221202100841.4741-10-ilpo.jarvinen@linux.intel.com> <Y4xr+nmx7m66+KsL@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-538923647-1670179839=:1606"
Content-ID: <7d35311e-c7-4d76-33f7-3126acf7f5bd@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-538923647-1670179839=:1606
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <a776598-a041-963f-ae15-994e22f9a29f@linux.intel.com>

On Sun, 4 Dec 2022, Greg KH wrote:

> On Fri, Dec 02, 2022 at 12:08:41PM +0200, Ilpo Järvinen wrote:
> > "GPL v2" should not be used as MODULE_LICENSE(). "GPL" is enough, see
> > commit bf7fbeeae6db ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL
> > v2" bogosity") for more details.
> 
> And that commit says that leaving "GPL v2" is just fine and dandy and
> should not be an issue at all.

From reading just it's changelog, it's hard to come into that conclusion
(in fact, the opposite reading is very much crafted into many of the 
wordings in the changelog, e.g., stating that "GPL" is "completely 
sufficient" and that other ways assume wrongly distinction, etc.).

Only after reading now the diff itself, I can see that being the case.

> Please do not change the license for no good reason.  That commit is NOT
> a good reason to change it at all.
> 
> so NAK on this patch, sorry.

Okay, I'm certainly fine dropping it :-).

The reason why I added this change was checkpatch giving this:

WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module: 
Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")

...And bf7fbeeae6db's changelog then further reinforced that "GPL" is 
sufficient.

I guess checkpatch wanted to give the warning only for new stuff but 
since I was moving code around it misdetected the moved bits as new.


-- 
 i.
--8323329-538923647-1670179839=:1606--
