Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7002FA568
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Jan 2021 16:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405938AbhARP6F (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 18 Jan 2021 10:58:05 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:37780 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405901AbhARPrz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 18 Jan 2021 10:47:55 -0500
Received: by mail-ot1-f50.google.com with SMTP id o11so16656713ote.4;
        Mon, 18 Jan 2021 07:47:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=WHAijgRPzgM6AOFxyA1t0PneGLCP7qF9iSM709PN7no=;
        b=gSiTDR/yvkXHwlbpvd1f0RUm8x1TJDtM3cnPi9GufhQIKSrfrjzm5ICmHFJd4Bq0bw
         w7JpYOYMXlh0uTxhlabov4J261Q7WVOcjsyEnnJV0ZNtq/CcvLVWzZcHBUem10xr8q3n
         UFiwMdvvHrMMNUR9M2l5r4WMyq/A+7ysECfMEt3luw6uy3Af+56XXmtUK48r7dYMKaKT
         R34b2YDs83H39zOlQ1/Z1EO84cS0bteIONKSKjC2nfSKwMjXpbWRTWYEW9S3FF1UHkgN
         YwMhJffmjR2y/NKGTK4jYMqj+qz7ERhM8Il5mSth6T2J3hZDGEFHP8qx3H3a/4NKmohY
         jyNQ==
X-Gm-Message-State: AOAM531r2C5TD9a84TX36+Pfkln5HiVlQVHWw5cmL79hbK+hk3dgJVy3
        lfI3Rt6aqYv4t5HZL4ORAA==
X-Google-Smtp-Source: ABdhPJwMs7UNxARBHzKpWRi3Gfe2AEbExUF2dRMnHv6f7YY4I9jyFTC64qaSblOnLQPi2S5WTivgVg==
X-Received: by 2002:a9d:6255:: with SMTP id i21mr66114otk.346.1610984832609;
        Mon, 18 Jan 2021 07:47:12 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x31sm3819079otb.4.2021.01.18.07.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 07:47:10 -0800 (PST)
Received: (nullmailer pid 3984439 invoked by uid 1000);
        Mon, 18 Jan 2021 15:47:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        linux-kernel@vger.kernel.org, mdf@kernel.org, robh+dt@kernel.org,
        trix@redhat.com, devicetree@vger.kernel.org, git@xilinx.com,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        chinnikishore369@gmail.com, michal.simek@xilinx.com
In-Reply-To: <20210118024318.9530-2-nava.manne@xilinx.com>
References: <20210118024318.9530-1-nava.manne@xilinx.com> <20210118024318.9530-2-nava.manne@xilinx.com>
Subject: Re: [PATCH 2/3] dt-bindings: fpga: Add binding doc for versal fpga manager
Date:   Mon, 18 Jan 2021 09:47:02 -0600
Message-Id: <1610984822.721524.3984438.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 18 Jan 2021 08:13:17 +0530, Nava kishore Manne wrote:
> From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> 
> This patch adds binding doc for versal fpga manager driver.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> ---
>  .../bindings/fpga/xlnx,versal-fpga.yaml       | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml:15:1: [error] syntax error: could not find expected ':' (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.example.dts'
Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 45, in <module>
    binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 343, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 111, in get_single_data
    node = self.composer.get_single_node()
  File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
  File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 891, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: while scanning a simple key
  in "<unicode string>", line 14, column 1
could not find expected ':'
  in "<unicode string>", line 15, column 1
make[1]: *** [Documentation/devicetree/bindings/Makefile:20: Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml:  while scanning a simple key
  in "<unicode string>", line 14, column 1
could not find expected ':'
  in "<unicode string>", line 15, column 1
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
make: *** [Makefile:1370: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1427979

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

