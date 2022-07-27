Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FAE582018
	for <lists+linux-fpga@lfdr.de>; Wed, 27 Jul 2022 08:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiG0GZn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 27 Jul 2022 02:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiG0GZl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 27 Jul 2022 02:25:41 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8D5248D1;
        Tue, 26 Jul 2022 23:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=kgGiHabl0/d2c20Z+4lE361tfrM1XekbYouuRVgUfS8=;
        b=T/0l3MGwNWjkjtS8LmH59PhhgDtw21q1DFl8xWja3mKUiAwc2hwiztH3wDTh+nkghjW2JMj5mVxDa
         FptKOqFzTBersO/hetIFz86LymsKWrGnXqnhqp9gzZgKr7VphJpLlSGmvBbdW4oS59RVFMPhhueeVF
         QxXFwzhNyG5REqVUto1y0MosnHkFmeZ4ITF15W1QSmYolyJhRli3EGIjnU9MBz7lr7AsWq7VcvXM/Q
         bMXp/Usq1ppehWnaHyD7wTiCj0XbG5JWHRcFBOu66vUNDh/gr5odoBxJRSj1nKEbGC0Gple9MUKoKb
         VFuCHB4FQk0cZHiz/IA5/TcqZ6etBew==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000008,0.007390)], BW: [Enabled, t: (0.000013,0.000001)], RTDA: [Enabled, t: (0.076210), Hit: No, Details: v2.41.0; Id: 15.52k4j7.1g8v59cer.4ih1; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([85.93.58.13])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Wed, 27 Jul 2022 09:25:12 +0300
Date:   Wed, 27 Jul 2022 09:00:30 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH v5 0/2] Lattice ECP5 FPGA manager
Message-ID: <20220727060030.7tlhisjwmm5wqjac@x260>
References: <20220719112335.9528-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719112335.9528-1-i.bornyakov@metrotek.ru>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jul 19, 2022 at 02:23:33PM +0300, Ivan Bornyakov wrote:
> Add support to the FPGA manager for programming Lattice ECP5 FPGA over
> slave SPI interface with .bit formatted uncompressed bitstream image.
> 
> ChangeLog:
>   v1 -> v2:
>     * remove "spi" from compatible string
>     * reword description in dt-bindings doc
>     * add reference to spi-peripheral-props.yaml in dt-binding doc
>     * fix DTS example in dt-bindings doc: 4-spaces indentations, no
>       undersores in node names.
>   v2 -> v3:
>     * fix typo "##size-cells" -> "#size-cells" in dt-bindings example
>   v3 -> v4:
>     * dt-bindings: reword description
>     * dt-bindings: revert props order
>   v4 -> v5:
>     * dt-bindings: remove trailing dot from title
>     * dt-bindings: reword description to avoid driver reference
>     * dt-bindings: add "Reviewed-by: Krzysztof Kozlowski" tag
> 
> Ivan Bornyakov (2):
>   fpga: ecp5-spi: add Lattice ECP5 FPGA manager
>   dt-bindings: fpga: add binding doc for ecp5-spi fpga mgr
> 
>  .../bindings/fpga/lattice,ecp5-fpga-mgr.yaml  |  74 +++++
>  drivers/fpga/Kconfig                          |   7 +
>  drivers/fpga/Makefile                         |   1 +
>  drivers/fpga/ecp5-spi.c                       | 275 ++++++++++++++++++
>  4 files changed, 357 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml
>  create mode 100644 drivers/fpga/ecp5-spi.c
> 
> -- 
> 2.37.1
> 

Friendly ping.

