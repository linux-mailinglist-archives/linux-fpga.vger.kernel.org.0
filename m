Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BDD58659D
	for <lists+linux-fpga@lfdr.de>; Mon,  1 Aug 2022 09:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiHAHYz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 1 Aug 2022 03:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiHAHYy (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 1 Aug 2022 03:24:54 -0400
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B501151;
        Mon,  1 Aug 2022 00:24:52 -0700 (PDT)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 771665FC5A;
        Mon,  1 Aug 2022 09:24:50 +0200 (CEST)
Date:   Mon, 1 Aug 2022 09:24:49 +0200
From:   Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: Re: [PATCH v5 1/2] fpga: ecp5-spi: add Lattice ECP5 FPGA manager
Message-ID: <20220801072448.GA11993@homes.emlix.com>
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
> +	/* Enter init mode */
> +	gpiod_set_value(priv->program, 1);
> +
> +	ret = ecp5_poll_gpio(priv->init, true);
> +	if (!ret)
> +		ret = ecp5_poll_gpio(priv->done, false);
> +
> +	if (ret) {
> +		dev_err(dev, "Failed to go to initialization mode\n");
> +		return ret;
> +	}

To me the documentation looks like the chip will deassert INITN after
tINITL regardless of the PROGRAMN signal. At 55ns max tINITL is too
short to reliably sample INITN while it is asserted when we have
interrupts enabled. Can you confirm that INITN stays asserted as long
as PROGRAMN is asserted?

Best regards,

  Daniel
