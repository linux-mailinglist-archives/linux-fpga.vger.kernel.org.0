Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E58359FF7F
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Aug 2022 18:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbiHXQ0l (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Aug 2022 12:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiHXQ0k (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 24 Aug 2022 12:26:40 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2448D82D19
        for <linux-fpga@vger.kernel.org>; Wed, 24 Aug 2022 09:26:39 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id v10so16899274ljh.9
        for <linux-fpga@vger.kernel.org>; Wed, 24 Aug 2022 09:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Xn8hCbME0CLHtDY+K08rpqn2b9T5jOnQqHQ0Tadc/E8=;
        b=fsVxa4KsdNTFpBXWYWfXcWhQCndK1yvR28rVyy2ZXL0xF2XIYfsr+5nz6wGzLlVQba
         DETEQuUq+inOiyV6lseZ1wlCLQo9HvS8vXgcp9IsVe1874ZrKBcrlHEZ+lWX+zpG6fHs
         mC37yvBFNseAUS+NbZAnczJYPyjhn5vIKkPLZo2ddOlRsKkPdp96N0v9uus392KOoVR2
         nESmwB5yG2T3ogfuRlDRnU5FLIZsmKa9NIF0fNl68dqm2cnXm8mSBzK+CjBovWzMZWnl
         /iurdUX3ZfCbNelFsY9S9UvWx2emY24dHOWtfy7krWkRycYuHkzbM4GcASNyMOQTHO14
         fkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Xn8hCbME0CLHtDY+K08rpqn2b9T5jOnQqHQ0Tadc/E8=;
        b=tLGCAlZpQRlCFFF4uxO4XUAMQ/jD3qiqYZNkZJGigNODST4R9rctZNj1o+Zt5W13TZ
         ze4EXv1GaqMShWryRXoXPJ6BA2+QVZYYS/igiGL80DeWpork/Wz7PorGYnCiVqoPVKwH
         +1WhAwJ13hbVfoc1+RIdn8PDv30gwjGIC9h+2e/Xgz8HP2OZ9J1HQB12ff5F1q0a7JjE
         Ww64bCkSyYx8k/Tj6f0JMHOtypaEZdT+yGFz69+dthtNE4jj8cqXv+goImEGwFlcNIf/
         DOkbP/n68NwvwHOc2NZQ5E5718r6DdmtnjdcmMZ5QXUnnDWgtb9PtU/8WkCrdsQrv9dS
         nIHw==
X-Gm-Message-State: ACgBeo3CYKR76pfrUu+hsv1+lUFvSAIvag/ISZaFwCZEdLGgFiTj2Sns
        z/iE/HwU6yS7Q2LGf/Ht//Q8qA==
X-Google-Smtp-Source: AA6agR43a3Gy3O6UhENmyBSqR+hKIEWrMQCOO0g/hZqfu4+t+cQWfiBElqHDj3umAMwpJmnZsfZkhw==
X-Received: by 2002:a2e:2e02:0:b0:261:cc4f:1ab3 with SMTP id u2-20020a2e2e02000000b00261cc4f1ab3mr5234lju.83.1661358397508;
        Wed, 24 Aug 2022 09:26:37 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id v3-20020a056512348300b0048af6242892sm1541019lfr.14.2022.08.24.09.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 09:26:36 -0700 (PDT)
Message-ID: <9e52af46-113f-e419-6cbd-729ae8caf36e@linaro.org>
Date:   Wed, 24 Aug 2022 19:26:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v7 2/2] dt-bindings: fpga: document Lattice sysCONFIG FPGA
 manager
Content-Language: en-US
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        dg@emlix.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
References: <20220824150114.17504-1-i.bornyakov@metrotek.ru>
 <20220824150114.17504-3-i.bornyakov@metrotek.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220824150114.17504-3-i.bornyakov@metrotek.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 24/08/2022 18:01, Ivan Bornyakov wrote:
> Add Device Tree Binding doc for configuring Lattice ECP5 and MachXO2
> FPGAs over Slave SPI sysCONFIG interface.
> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---
>  .../bindings/fpga/lattice,sysconfig.yaml      | 103 ++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
> 
> diff --git a/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml b/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
> new file mode 100644
> index 000000000000..596776427a00
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
> @@ -0,0 +1,103 @@
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
> +        program-gpios:
> +          description:
> +            A GPIO line connected to PROGRAMN (active low) pin of the device.
> +            Initiates configuration sequence.
> +          maxItems: 1
> +        init-gpios:
> +          description:
> +            A GPIO line connected to INITN (active low) pin of the device.
> +            Indicates that the FPGA is ready to be configured.
> +          maxItems: 1
> +        done-gpios:
> +          description:
> +            A GPIO line connected to DONE (active high) pin of the device.
> +            Indicates that the configuration sequence is complete.
> +          maxItems: 1

Define instead the properties in top-level properties and disallow them
for other variant (program-gpios: false). Required can stay.

> +      required:
> +        - program-gpios
> +        - init-gpios
> +        - done-gpios
> +


Best regards,
Krzysztof
