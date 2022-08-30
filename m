Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81205A6E99
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Aug 2022 22:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiH3Uku (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 Aug 2022 16:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiH3Ukt (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 30 Aug 2022 16:40:49 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0385322B0E;
        Tue, 30 Aug 2022 13:40:49 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-11f0fa892aeso11369416fac.7;
        Tue, 30 Aug 2022 13:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=28uX6UR7soMe9bRpbpyv9Nra+Ki7dVg3olvPIlkax2g=;
        b=ajHo/TuFcWqd46GObbVVnPvcjmPkyQnfmwCgbCC88jepaLYAcETi39R1wqV3JfKANV
         st6xtQqY2hK6fe9yHcOLSOryfdDoMQhugHUoQSsFOrKndAtLP6dWB0y/LwCevM33ySwE
         3ePKw3ennz9sKV2dPkCa0y2AypwcEHjuFGaikxig74uMXq5qNRJd7oXiGz8h+71qDwFw
         0wAltGBXoa90JCF325y3OENKy1WEH0mdI1sMlUTaJHQdIeJ4U3iLCKwr2fQmbaKhwB0I
         vvqzCoxrPUE05dFbLVvPO64wnE2POU0NRRMhalWxRBVkzziJncz0eMsqnha9nsX9VXu3
         xN+Q==
X-Gm-Message-State: ACgBeo3mnCmM7LR4emarxThG16vkkG5Qw1PfWo3X3drUUBcKCf5j57Tm
        AL0Iq6Tz81EtGN6iqYzG9w==
X-Google-Smtp-Source: AA6agR5CyQ1piJA2C09FZxql12P9s7tM78Ic3uexyvETLBGbFxH2J+HgJcmUkSUUVWOnuzSfluHpOg==
X-Received: by 2002:a05:6871:88d:b0:11d:83fe:9062 with SMTP id r13-20020a056871088d00b0011d83fe9062mr721oaq.53.1661892048290;
        Tue, 30 Aug 2022 13:40:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bb8-20020a056820160800b004320b0cc5acsm7457372oob.48.2022.08.30.13.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 13:40:48 -0700 (PDT)
Received: (nullmailer pid 2027328 invoked by uid 1000);
        Tue, 30 Aug 2022 20:40:47 -0000
Date:   Tue, 30 Aug 2022 15:40:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, kernel@pengutronix.de
Subject: Re: [PATCH 04/16] dt-bindings: fpga: machxo2-slave: add
 lattice,machxo2-slave-i2c compatible
Message-ID: <20220830204047.GA2021641-robh@kernel.org>
References: <20220825141343.1375690-1-j.zink@pengutronix.de>
 <20220825141343.1375690-5-j.zink@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825141343.1375690-5-j.zink@pengutronix.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Aug 25, 2022 at 04:13:31PM +0200, Johannes Zink wrote:
> Lattice MachXO2 FPGAs allow reconfiguration over I2C as well as over
> SPI. Add the I2C option to the binding as well.
> 
> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> ---
>  .../bindings/fpga/lattice,machxo2-slave.yaml         | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml b/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
> index 03dc134ec7b8..d48d92f27c92 100644
> --- a/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
> +++ b/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
> @@ -21,10 +21,22 @@ allOf:
>              const: lattice,machxo2-slave-spi
>      then:
>        $ref: /schemas/spi/spi-peripheral-props.yaml#

Okay, I guess you do need the if/then. Technically, you don't need it 
til this patch, but that's fine.

The allOf/if part should go after 'required' section though.

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: lattice,machxo2-slave-i2c
> +    then:
> +      properties:
> +        reg:
> +          description: I2C address
> +          maxItems: 1

'reg' is needed in either case. The only conditional part is the 
description which you don't need. So this can be dropped.

> +
>  properties:
>    compatible:
>      enum:
>        - lattice,machxo2-slave-spi
> +      - lattice,machxo2-slave-i2c
>  
>    program-gpios:
>      maxItems: 1
> -- 
> 2.30.2
> 
> 
