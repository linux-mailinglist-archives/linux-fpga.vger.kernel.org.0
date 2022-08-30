Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DBD5A6E7B
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Aug 2022 22:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiH3UbB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 Aug 2022 16:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiH3UbA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 30 Aug 2022 16:31:00 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4911A7960E;
        Tue, 30 Aug 2022 13:30:57 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id m21-20020a9d6ad5000000b00638df677850so8905171otq.5;
        Tue, 30 Aug 2022 13:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=rmEy0B0NtOXNNKtRjySg/TnwvjbOM4n62zg2mMsSUUM=;
        b=S+RAlKcPtTArCB6eGF3BfQDOwZfzYQwnejqXVAHb7DvOS4M9BjLd+ct4x6cecUAfcE
         9cqDw5e0UjmXoKxHtDFeu43XKDXDEZbFsa4PgycT4Tgif2MFGmocG0/ITqW6qR3TO1mC
         9FUgXA7g0SgU06LT3mrn+xKq3weQiWmWYhuVBBkyOu7nr0dM+iqO/AdG3JEAh3rJK7nL
         vNMjrOIukgrayjYoUoVmNfiKgwn6QWLEBKMp2dOIiDQj5LesQirOA6XyPK4Xy+ifENII
         +sm0fhc934UloGjvjHCjpGdaibVOeXzSv/q2qNYNyfLhoaxlthdDQKfwFSiD23e9MBJn
         YgHA==
X-Gm-Message-State: ACgBeo1qDNsKkZbLCzDx8US2ziFXxexVojDfGYD5JfAjKL5U2iI9GI7F
        k2LzfXEspNQccCeEZ8tJ+A==
X-Google-Smtp-Source: AA6agR6wv7sb60rVMo+ajcw6DL4GkCgRNMsmx4TQGT5PNfIatpDtqpF4AOiv2Fbpo0IHQj9Nnm735A==
X-Received: by 2002:a05:6830:4429:b0:638:8f6c:2096 with SMTP id q41-20020a056830442900b006388f6c2096mr8973978otv.336.1661891456864;
        Tue, 30 Aug 2022 13:30:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bj37-20020a05680819a500b0033ad6ea8d11sm6704102oib.47.2022.08.30.13.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 13:30:56 -0700 (PDT)
Received: (nullmailer pid 2011586 invoked by uid 1000);
        Tue, 30 Aug 2022 20:30:55 -0000
Date:   Tue, 30 Aug 2022 15:30:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, kernel@pengutronix.de
Subject: Re: [PATCH 01/16] dt-bindings: fpga: convert Lattice MachXO2 Slave
 binding to YAML
Message-ID: <20220830203055.GA2003370-robh@kernel.org>
References: <20220825141343.1375690-1-j.zink@pengutronix.de>
 <20220825141343.1375690-2-j.zink@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825141343.1375690-2-j.zink@pengutronix.de>
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

On Thu, Aug 25, 2022 at 04:13:28PM +0200, Johannes Zink wrote:
> This commit prepares adding additional properties to the machxo2-slave
> device. No functional changes.

Please use get_maintainers.pl so *all* the maintainers/lists get Cc'ed. 

> 
> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> ---
>  .../bindings/fpga/lattice,machxo2-slave.yaml  | 46 +++++++++++++++++++
>  .../bindings/fpga/lattice-machxo2-spi.txt     | 29 ------------
>  2 files changed, 46 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
>  delete mode 100644 Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt
> 
> diff --git a/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml b/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
> new file mode 100644
> index 000000000000..d05acd6b0fc6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/lattice,machxo2-slave.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Lattice MachXO2 Slave FPGA Manager Device Tree Bindings
> +
> +maintainers:
> +  - Johannes Zink <j.zink@pengutronix.de>
> +
> +description: |
> +  Device used for loading the bitstream of Lattice MachXO2 FPGAs. The
> +  programming sequence is described in FPGA-TN-02155 on www.latticesemi.com
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: lattice,machxo2-slave-spi
> +    then:
> +      $ref: /schemas/spi/spi-peripheral-props.yaml#

You don't need the 'if' because the schema is only applied if the 
compatible matches.

Blank line needed here.

> +properties:
> +  compatible:
> +    enum:
> +      - lattice,machxo2-slave-spi
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        fpga@0 {
> +            compatible = "lattice,machxo2-slave-spi";
> +            spi-max-frequency = <8000000>;
> +            reg = <0>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt b/Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt
> deleted file mode 100644
> index a8c362eb160c..000000000000
> --- a/Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -Lattice MachXO2 Slave SPI FPGA Manager
> -
> -Lattice MachXO2 FPGAs support a method of loading the bitstream over
> -'slave SPI' interface.
> -
> -See 'MachXO2ProgrammingandConfigurationUsageGuide.pdf' on www.latticesemi.com
> -
> -Required properties:
> -- compatible: should contain "lattice,machxo2-slave-spi"
> -- reg: spi chip select of the FPGA
> -
> -Example for full FPGA configuration:
> -
> -	fpga-region0 {
> -		compatible = "fpga-region";
> -		fpga-mgr = <&fpga_mgr_spi>;
> -		#address-cells = <0x1>;
> -		#size-cells = <0x1>;
> -	};
> -
> -	spi1: spi@2000 {
> -        ...
> -
> -		fpga_mgr_spi: fpga-mgr@0 {
> -			compatible = "lattice,machxo2-slave-spi";
> -			spi-max-frequency = <8000000>;
> -			reg = <0>;
> -		};
> -	};
> -- 
> 2.30.2
> 
> 
