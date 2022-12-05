Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E34C6425D8
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Dec 2022 10:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiLEJbP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Dec 2022 04:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiLEJbO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Dec 2022 04:31:14 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EA215738;
        Mon,  5 Dec 2022 01:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670232673; x=1701768673;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=qmdPQJNEf7eEHF3sDdSTyBngvNyJ+GF+o4Oj9/U+IfY=;
  b=TAmT0tWPNnTu3cWmNR8JbAEgSOKGSaFjUHbI8ct2xF7/5FJtWs+XsI8H
   wjCULbsFd2RafD624YnTm4V2TarfvD8FMnUp+VGW2SNt8r82jyUf1YD2j
   orrbpZR1SrCoadEpRzSbpxtW+cuAFK8SC0g7diLrUx2OSUXKZzeloH6UH
   wVUygPqMinqCSFcYNvCFEMFuQydYsKzjnma8AHJ9OnHEIuum4PKhbI0bU
   yEj9iDrZPkAn1CeoU6AC2U+hgtVhQLEz7Om90H13CjiztzGybCxHEhI01
   za8HIpfRba13cDSiM4dGIKEgvyPVeu+V2v+R6gGVFUrCxFA8qXGS0+zso
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="299731606"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="299731606"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 01:31:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="596138379"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="596138379"
Received: from andreial-mobl.ger.corp.intel.com ([10.251.213.105])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 01:31:09 -0800
Date:   Mon, 5 Dec 2022 11:31:06 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
cc:     Xu Yilun <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 6/9] mfd: intel-m10-bmc: Downscope SPI defines & prefix
 with M10BMC_SPI
In-Reply-To: <2b253321-72ff-f15a-8879-aa41dce48055@intel.com>
Message-ID: <b09aabe4-3f82-70f0-aca2-f1cdf7d6a26@linux.intel.com>
References: <20221202100841.4741-1-ilpo.jarvinen@linux.intel.com> <20221202100841.4741-7-ilpo.jarvinen@linux.intel.com> <Y4onmwWT8duVV0Sv@yilunxu-OptiPlex-7050> <2b253321-72ff-f15a-8879-aa41dce48055@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-626232090-1670231392=:1615"
Content-ID: <3fba579-a55c-b93f-79d-7e89e6e35b0@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-626232090-1670231392=:1615
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <5f2a86c-6cce-7de1-3997-e5462b8f041@linux.intel.com>

On Fri, 2 Dec 2022, Russ Weight wrote:
> On 12/2/22 08:28, Xu Yilun wrote:
> > On 2022-12-02 at 12:08:38 +0200, Ilpo Järvinen wrote:
> >> Move SPI based board definitions to per interface file from the global
> >> header. This makes it harder to use them accidently in the
> >> generic/interface agnostic code. Prefix the defines with M10BMC_SPI
> > I'm not sure if the register layout is actually bound to the bus
> > interface. My experience is the register layout is always decided by
> > board type. Is it possible there will be a new SPI based board but
> > has different register layout in future?
> >
> > So is M10BMC_SPI_XXX a good nam
> 
> There could be future devices, spi or pmci based, that require different
> addresses for some of these values, and at that time we would need to
> additional versions of some of these macros using different names.
> Right now, spi and pmci are the primary differentiating factors. I'm not
> sure how to improve on the naming. Do you have any suggestions?

It's per board type yes, but there's a strong clustering currently on 
spi/pmci differentiation. That implies a one define applies to multiple 
board types so naming it, e.g., after a single board type seems not much 
better than the current approach.

I've even thought myself of removing those defines as they seem one-time 
use ones after introducing the csr_map. Defining the csr_map using members
kinda documents what a literal is about if I'd put just a number there.
The added benefit a few capital letters in a define provides is IMHO very
questionable.

Also m10bmc_spi_csr_map name suffers from the same problem, BTW.

I could, of course now that they're downscoped, drop _SPI_ or _PMCI_ from 
their names if that's ok for you? ...But that wouldn't address the next 
version naming problem at all. But I don't anyway know, without a crystal 
ball, know how to address the future naming needs.

-- 
 i.
--8323329-626232090-1670231392=:1615--
