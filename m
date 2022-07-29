Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72586584DDE
	for <lists+linux-fpga@lfdr.de>; Fri, 29 Jul 2022 11:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbiG2JIb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 29 Jul 2022 05:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiG2JIb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 29 Jul 2022 05:08:31 -0400
X-Greylist: delayed 422 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 29 Jul 2022 02:08:29 PDT
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6520C84EF0;
        Fri, 29 Jul 2022 02:08:29 -0700 (PDT)
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 7EB5F60344;
        Fri, 29 Jul 2022 11:01:24 +0200 (CEST)
Date:   Fri, 29 Jul 2022 11:01:24 +0200
From:   Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 2/2] dt-bindings: fpga: add binding doc for ecp5-spi
 fpga mgr
Message-ID: <20220729090123.GA28299@homes.emlix.com>
References: <20220719112335.9528-1-i.bornyakov@metrotek.ru>
 <20220719112335.9528-3-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719112335.9528-3-i.bornyakov@metrotek.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi,

On Tue, Jul 19, 2022 at 02:23:35PM +0300, Ivan Bornyakov wrote:
> +properties:
> +  compatible:
> +    enum:
> +      - lattice,ecp5-fpga-mgr

Since this driver uses the same interface as the existing
drivers/fpga/machxo2-spi.c driver, wouldn't it be advisable to use a
similar compatible id, i.e. lattice,ecp5-slave-spi?

> +required:
> +  - compatible
> +  - reg
> +  - program-gpios
> +  - init-gpios
> +  - done-gpios

I think some of the GPIOs can be made optional by reading the status
register or using the refresh command, assuming the slave spi interface
stayed enabled after previous programming and we are not dealing with
several chained FPGAs. But that can of course be left as an exercise for
other developers.

Best regards,

  Daniel
