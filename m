Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D0567E1CE
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Jan 2023 11:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjA0KgV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 27 Jan 2023 05:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjA0KgS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 27 Jan 2023 05:36:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5400079630;
        Fri, 27 Jan 2023 02:36:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0A0061AE4;
        Fri, 27 Jan 2023 10:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE0DC4339B;
        Fri, 27 Jan 2023 10:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674815772;
        bh=vw0iiYxGTCesFwa72RlwSdRCpxQWJUUPK745DxXrCUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Id6qV15kooUPWdHl4wyDEwnRgvOc2+29dUbHInSpAvRIRX6L27wWP4F9gYc/qx2Wx
         yLrku+TkgmP/GZ5Q29QiGdwH3Cpv410ahtzDpayjiYIcdGoqUueGnsBhNom6pO3XtO
         40CkRIns8lVuV/VWzJf2nFLfYFBusSqUmFZkRikBXlzl8JhOIPZyBu2DxMKmA8qSg/
         94pX7quhPoYH+7U1EKPZOV1KSTBSITsAY2jXTB20+B6uIRFBYYXg91CSVCRQVQ6SMv
         K/r8TuZIDqNyGXERee86EJkfDF/sQMtp72RXoa+3B+2koH0cZxzvXaXgufubDrIPRn
         PHg05faGWWHGA==
Date:   Fri, 27 Jan 2023 10:36:06 +0000
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
Subject: Re: [PATCH v6 05/11] mfd: intel-m10-bmc: Support multiple CSR
 register layouts
Message-ID: <Y9OpFg1guvR1cByY@google.com>
References: <20230116100845.6153-1-ilpo.jarvinen@linux.intel.com>
 <20230116100845.6153-6-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230116100845.6153-6-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 16 Jan 2023, Ilpo Järvinen wrote:

> There are different addresses for the MAX10 CSR registers. Introducing
> a new data structure m10bmc_csr_map for the register definition of
> MAX10 CSR.
> 
> Provide the csr_map for SPI.
> 
> Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> Acked-for-MFD-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 73 +++++++++++++++++--------
>  drivers/mfd/intel-m10-bmc-core.c        | 10 ++--
>  drivers/mfd/intel-m10-bmc-spi.c         | 23 ++++++++
>  include/linux/mfd/intel-m10-bmc.h       | 38 +++++++++++--
>  4 files changed, 111 insertions(+), 33 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
