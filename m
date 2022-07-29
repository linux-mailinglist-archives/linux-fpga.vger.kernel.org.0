Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08A4585028
	for <lists+linux-fpga@lfdr.de>; Fri, 29 Jul 2022 14:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiG2Mlu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 29 Jul 2022 08:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiG2Mlu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 29 Jul 2022 08:41:50 -0400
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052A854AFC;
        Fri, 29 Jul 2022 05:41:46 -0700 (PDT)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 3C8EF5FED8;
        Fri, 29 Jul 2022 14:41:45 +0200 (CEST)
Date:   Fri, 29 Jul 2022 14:41:44 +0200
From:   Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: Re: [PATCH v5 1/2] fpga: ecp5-spi: add Lattice ECP5 FPGA manager
Message-ID: <20220729124143.GA31715@homes.emlix.com>
References: <20220719112335.9528-1-i.bornyakov@metrotek.ru>
 <20220719112335.9528-2-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719112335.9528-2-i.bornyakov@metrotek.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi,

On Tue, Jul 19, 2022 at 02:23:34PM +0300, Ivan Bornyakov wrote:
> +	struct spi_transfer lsc_xfers[] = {
> +		{
> +			.tx_buf = lsc_init_addr,
> +			.len = sizeof(lsc_init_addr),
> +			.cs_change = 1,
> +		}, {
> +			.tx_buf = lsc_bitstream_burst,
> +			.len = sizeof(lsc_bitstream_burst),
> +			.cs_change = 1,
> +		},
> +	};

cs_change in the last transfer of a message will not prevent transfers
with other spi devices on the bus from taking place. You want to use
spi_bus_lock and friends in addition.

Best regards,

  Daniel
