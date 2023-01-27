Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588A067E19C
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Jan 2023 11:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjA0K2G (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 27 Jan 2023 05:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjA0K2E (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 27 Jan 2023 05:28:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7DF12F20;
        Fri, 27 Jan 2023 02:28:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 268E661AAD;
        Fri, 27 Jan 2023 10:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE04FC433D2;
        Fri, 27 Jan 2023 10:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674815282;
        bh=Uc5lAD2Pgf7RWG6PQ1G5xih0zUT75FH8hOdZ+sEpqTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KV0P6Ds4TLVsJa1SW84X61NpG/cvNcFdT4X9WgFYfgPLCD73O83/1lrq0fD4ZE4qh
         5uIzavlVHCP79xbPy987Y1TW2lCfJbbFhNnn3k05o9xNK9/Rl2SbrOICYbzm/zrJv7
         fuFdz6ZLvj4atEwlK5ciTvvEW4RsakK5TUfYIZNBuVWwU3VUYiM3xKLUsmDzauo9Mf
         2BWrMM/MJz8fcW9Nclhrb695UFvUEVYue+MOSLxtxmV1OXOx5IbBdim1XWRbe9jUP2
         3dBnOBdVC4POH2EnRv7NrWxoPuZxszOkRH/OLr3zhCZKHZm4CU2BoXTFdZ3d5F2Vfo
         8KKTA0rI2Ek5w==
Date:   Fri, 27 Jan 2023 10:27:56 +0000
From:   Lee Jones <lee@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/11] mfd: intel-m10-bmc: Add missing includes to
 header
Message-ID: <Y9OnLPRCmVi0CICn@google.com>
References: <20230116100845.6153-1-ilpo.jarvinen@linux.intel.com>
 <20230116100845.6153-2-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230116100845.6153-2-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 16 Jan 2023, Ilpo Järvinen wrote:

> linux/mfd/intel-m10-bmc.h is using:
> 	- pr_err(), thus include also linux/dev_printk.h
> 	- FIELD_GET(), this include also linux/bitfield.h
> 	- GENMASK(), thus include also linux/bits.h
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  include/linux/mfd/intel-m10-bmc.h | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
