Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9298F74D8AF
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Jul 2023 16:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjGJOLk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Jul 2023 10:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjGJOLj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 Jul 2023 10:11:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E26AD;
        Mon, 10 Jul 2023 07:11:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E793760FE9;
        Mon, 10 Jul 2023 14:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC73BC433C7;
        Mon, 10 Jul 2023 14:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688998298;
        bh=KnoFgz/WVRm69Acdmguxy6Kmdym5tT/bK7QYbgZ1Gyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U27uaBqCHZ2xR2e09pZT/ldaLlsz1VKCWbQeri+Brc6VgkGU1ojfGSwxbN5L66nJn
         /nrCGLzgjt2ZVpHRqprD2Hxu1uy7rFCVXR2QKbkuakLstLY6dBlfBLyVVcsu5lKjXK
         rIlXiL/VR0wteIZwYx3anEMrMdUZsor38UBZtiXQ=
Date:   Mon, 10 Jul 2023 16:11:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Alan Tull <atull@opensource.altera.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] fpga: socfpga-a10: Fix incorrect return value of
 devm_regmap_init_mmio
Message-ID: <2023071010-anatomy-paying-3e3e@gregkh>
References: <20230710133830.65631-1-frank.li@vivo.com>
 <20230710133830.65631-3-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710133830.65631-3-frank.li@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jul 10, 2023 at 09:38:30PM +0800, Yangtao Li wrote:
> When devm_regmap_init_mmio fails, we should return PTR_ERR(priv->regmap)
> instead of -ENODEV.
> 
> Fixes: acbb910ae04b ("fpga-manager: Add Socfpga Arria10 support")

Why are you not also including a cc: stable@ tag here?

thanks,

greg k-h
