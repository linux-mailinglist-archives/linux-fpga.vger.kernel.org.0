Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED7364AF87
	for <lists+linux-fpga@lfdr.de>; Tue, 13 Dec 2022 06:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbiLMFzr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 13 Dec 2022 00:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiLMFzq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 13 Dec 2022 00:55:46 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0461A395;
        Mon, 12 Dec 2022 21:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670910946; x=1702446946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6AURILvDMEsQex/7H6ptrgXlVfLSbcE5QiOEKGDRanQ=;
  b=n3mwWcLYa/MeeDsEWel3CBYa+heNBwyT/mNjR15lCqT1jdxjuxVooviC
   lHivuHXFP7ESk1bEg5qJtzkGqBzhPKJZMgX5MUaOVIz4LXCxzhO2e/gwR
   qR2wpsmp2V7kbFxZTKHsQ/JGa587gMoNz+8ktswDRJZQ5ycMQdQiWdMgn
   9dM1VxOILaBZT55he1kAXT79wpe6Eq3knE7C0Ou8M84bpyifdWEkpT/5N
   DNrCxW83ta9YbkJ7ERMma8FQaEL3uJ+yfh514yJstkldZQsjJB3J6i7hG
   /PvecUs+SXuXy0dLfakQ1O7+kj2wtvBceC8fdl6EAS13jNw2Ua1TnkhKG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="319906812"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="319906812"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 21:55:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="755253831"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="755253831"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga002.fm.intel.com with ESMTP; 12 Dec 2022 21:55:42 -0800
Date:   Tue, 13 Dec 2022 13:45:51 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-fpga@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/8] mfd: intel-m10-bmc: Downscope SPI defines &
 prefix with M10BMC_N3000
Message-ID: <Y5gRj4iog9Q1f7vb@yilunxu-OptiPlex-7050>
References: <20221211103913.5287-1-ilpo.jarvinen@linux.intel.com>
 <20221211103913.5287-7-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221211103913.5287-7-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-12-11 at 12:39:11 +0200, Ilpo Järvinen wrote:
> Move SPI based board definitions to per interface file from the global
> header. This makes it harder to use them accidently in the
> generic/interface agnostic code. Prefix the defines with M10BMC_N3000
> to make it more obvious these are related to some board type. All
> current non-N3000 board types have the same layout so they'll be
> reused.
> 
> Some bitfield defs are also moved to intel-m10-bmc-core which seems
> more appropriate for them.
> 
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>
