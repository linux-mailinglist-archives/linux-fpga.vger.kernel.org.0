Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455A65A60DD
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Aug 2022 12:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiH3KdP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 Aug 2022 06:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH3KdO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 30 Aug 2022 06:33:14 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7364A3D5D;
        Tue, 30 Aug 2022 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=llGPjFGwJB/wfY44LT3rb5OTwIONCk545lArJ09EwdM=;
        b=d8NgS0QG94kN53tMYz9L97aD8JmAvM5y3Pjb+auL5tVDM7BRnTyjWX+fOsVxocIVCZx4ee8/d/FFA
         o6hbq2ALOKlQMPgZ+0AiK9avUSNlPVO0HMXeJb1tF1CKP8h3J5lHWSYD1AkT/vGoAhxm+Nq7rzQT20
         P8iQbpCJzGzVQ+XOuomBqZiV7By52iHjp9lN/RBtATnHOJPQPDdWagNZPTThL5RpBA/h8gjEaNphw7
         PgdMaWjFEOf1FLHCCOSiBpPFePcwtHpfeKgzfV/XkJKH9+xj9LGfX+IBwPKaoAgRG6vcV2Fn+h9v55
         kcHuRDIPcSBwRa67f2lkg01SGi0ALiw==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.4.1445, Stamp: 3], Multi: [Enabled, t: (0.000010,0.015701)], BW: [Enabled, t: (0.000014,0.000001)], RTDA: [Enabled, t: (0.078785), Hit: No, Details: v2.41.0; Id: 15.52kem9.1gbn4vlpc.vtp; mclb], total: 0(700)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Tue, 30 Aug 2022 13:33:03 +0300
Date:   Tue, 30 Aug 2022 13:32:01 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, dg@emlix.com, j.zink@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        system@metrotek.ru
Subject: Re: [PATCH v9 2/2] dt-bindings: fpga: document Lattice sysCONFIG
 FPGA manager
Message-ID: <20220830103201.dmtvotiq43g742v5@h-e2.ddg>
References: <20220830095405.31609-1-i.bornyakov@metrotek.ru>
 <20220830095405.31609-3-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830095405.31609-3-i.bornyakov@metrotek.ru>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Aug 30, 2022 at 12:54:05PM +0300, Ivan Bornyakov wrote:
> Add Device Tree Binding doc for configuring Lattice ECP5 and MachXO2
> FPGAs over Slave SPI sysCONFIG interface.
> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---
>  .../bindings/fpga/lattice,sysconfig.yaml      | 102 ++++++++++++++++++
>  1 file changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
> 
> diff --git a/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml b/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
> new file mode 100644
> index 000000000000..17f1e0c50bc4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/lattice,sysconfig.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Lattice Slave SPI sysCONFIG FPGA manager
> +
> +maintainers:
> +  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
> +
> +description: |
> +  Lattice sysCONFIG port, which is used for FPGA configuration, among others,
> +  have Slave Serial Peripheral Interface. Only full reconfiguration is
> +  supported.
> +
> +  Programming of ECP5 is done by writing uncompressed bitstream image in .bit
> +  format into FPGA's SRAM configuration memory.
> +
> +  Programming of MachXO2 is done by writing configuration data into device's
> +  internal non-volatile Flash memory, then Self-Download of data from Flash
> +  into SRAM is issued.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - lattice,ecp5-fpga-mgr
> +      - lattice,machxo2-fpga-mgr
> +
> +  reg:
> +    maxItems: 1
> +
> +  program-gpios:
> +    description:
> +      A GPIO line connected to PROGRAMN (active low) pin of the device.
> +      Initiates configuration sequence.
> +    maxItems: 1
> +
> +  init-gpios:
> +    description:
> +      A GPIO line connected to INITN (active low) pin of the device.
> +      Indicates that the FPGA is ready to be configured.
> +    maxItems: 1
> +
> +  done-gpios:
> +    description:
> +      A GPIO line connected to DONE (active high) pin of the device.
> +      Indicates that the configuration sequence is complete.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: lattice,machxo2-fpga-mgr
> +    then:
> +      properties:
> +        spi-max-frequency:
> +          maximum: 66000000
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: lattice,ecp5-fpga-mgr
> +    then:
> +      properties:
> +        spi-max-frequency:
> +          maximum: 60000000
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        fpga-mgr@0 {
> +            compatible = "lattice,ecp5-fpga-mgr";
> +            reg = <0>;
> +            spi-max-frequency = <20000000>;
> +            program-gpios = <&gpio3 4 GPIO_ACTIVE_LOW>;
> +            init-gpios = <&gpio3 3 GPIO_ACTIVE_LOW>;
> +            done-gpios = <&gpio3 2 GPIO_ACTIVE_HIGH>;
> +        };
> +
> +        fpga-mgr@1 {
> +            compatible = "lattice,machxo2-fpga-mgr";
> +            reg = <1>;
> +            spi-max-frequency = <20000000>;
> +        };
> +    };
> -- 
> 2.37.2
> 

Sorry, I forgot to add a tag from Krzysztof. Since there is not much
change here, I think the tag is still valid.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



