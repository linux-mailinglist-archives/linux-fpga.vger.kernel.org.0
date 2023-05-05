Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AE96F8A1F
	for <lists+linux-fpga@lfdr.de>; Fri,  5 May 2023 22:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjEEUUv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 5 May 2023 16:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjEEUUu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 5 May 2023 16:20:50 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903DE44A4;
        Fri,  5 May 2023 13:20:49 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1929818d7faso19936305fac.0;
        Fri, 05 May 2023 13:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683318049; x=1685910049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTp+ujuSARxg3oTk1x6HJVoiZDSGiq6VqHkpNl5nbtA=;
        b=RI7VvWbX2B3uH1n1Gk96fASrS5KoDIByx9qJ2xJKfkVkT4vKnvKUft1YsRSIGIA/Ij
         uBK3123AYBJNb6nFvgWQgJ30bQu1u8rlPuMCT86hVaCkwAGAUfuEUZj3zSbyabRb8enL
         eyPKZj+j63SDn6GCqRjBnssKAMspJ293DmjOKncSNSVGZIHlYi9L6FkUzXi5w9KitKh6
         7FW2bst55ujKorCkY5VBSytbITpn7cW5NYAwPGBKyFFLt0mEVPgmAvoQJvYZR1sR7dh+
         Cd3DOvAvz+qY5voqrkywd1xXV0L/aqSnwXSYl3/l9t/XS4XrIznGbnAQhdhNa3HDEwhk
         dhqA==
X-Gm-Message-State: AC+VfDxFIMRdwJR9JQzQlGagPSKauHEWyy2Yen69JbSI8Pm67RRIBm+M
        kI5aYq5zbwiiPPzB3CnJsg==
X-Google-Smtp-Source: ACHHUZ6+EawPnqOeB70i0DQrmo26aemxNHPvkAJ1k1xyLrXN/OWy8+121ave7gzNOhN9+SOn7P5YoA==
X-Received: by 2002:a4a:87c4:0:b0:547:6a8d:67b2 with SMTP id c4-20020a4a87c4000000b005476a8d67b2mr1488503ooi.0.1683318048777;
        Fri, 05 May 2023 13:20:48 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j19-20020a4adf53000000b0054c7ed51952sm1420024oou.0.2023.05.05.13.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 13:20:48 -0700 (PDT)
Received: (nullmailer pid 3501939 invoked by uid 1000);
        Fri, 05 May 2023 20:20:47 -0000
Date:   Fri, 5 May 2023 15:20:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     Rob Herring <robh+dt@kernel.org>, system@metrotek.ru,
        Wu Hao <hao.wu@intel.com>, devicetree@vger.kernel.org,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xu Yilun <yilun.xu@intel.com>,
        Vladimir Georgiev <v.georgiev@metrotek.ru>,
        Tom Rix <trix@redhat.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: fpga: replace Ivan Bornyakov
 maintainership
Message-ID: <168331804658.3501880.12172518458468106215.robh@kernel.org>
References: <20230429104838.5064-1-i.bornyakov@metrotek.ru>
 <20230429104838.5064-3-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230429104838.5064-3-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On Sat, 29 Apr 2023 13:48:38 +0300, Ivan Bornyakov wrote:
> As I'm leaving Metrotek, hand over Lattice Slave SPI sysCONFIG FPGA
> manager and Microchip Polarfire FPGA manager maintainership duties to
> Vladimir.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Vladimir Georgiev <v.georgiev@metrotek.ru>
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---
>  Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml   | 2 +-
>  .../devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

