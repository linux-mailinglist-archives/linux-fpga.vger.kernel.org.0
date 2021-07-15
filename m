Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D838A3C9F5D
	for <lists+linux-fpga@lfdr.de>; Thu, 15 Jul 2021 15:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbhGONV3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 15 Jul 2021 09:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59349 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229624AbhGONV2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 15 Jul 2021 09:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626355114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0xpUm/bZf/gJUFnUOsgmJ47taBTH+Qv6PQ/m3LfGTGw=;
        b=dOz8I00P/oXzgbHVZOyRTzizevR9MHm7uwD5cTggkXJCBmj2cMeqIel16gOVJv+6OBkGX7
        4FNT5HlbrolGCZ7iROju4MctQbpO/YekgooqE79NgBrFh7yViuzEKEE4WSbHS/r1FXTszc
        BxJ40fxUaBGe2LcxWmBNlBVFW5+Fn2k=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-WxSNEc49OGC26rVntN3EdA-1; Thu, 15 Jul 2021 09:18:34 -0400
X-MC-Unique: WxSNEc49OGC26rVntN3EdA-1
Received: by mail-qv1-f70.google.com with SMTP id e19-20020ad442b30000b02902dc988b8675so4116101qvr.3
        for <linux-fpga@vger.kernel.org>; Thu, 15 Jul 2021 06:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0xpUm/bZf/gJUFnUOsgmJ47taBTH+Qv6PQ/m3LfGTGw=;
        b=j6WdfUYbCAwtk4qU8p/vCwUatQw8IjTRPB3Mt+khrv4E7F5G34WQLb71DBg3gj9R4V
         VfD1ZzxJpVu6ia/KFg+MKjOVpdLcCM7E8yn5rs3wqoO337YunG6b1s4tOZvlmFfxo6kz
         hAwdxr0dPPBAQ4FvBCgwnjQx9hb4dU+0Dg9QFZ9tFF81Hn0aZHvBl59kT3wkX/DH82f2
         vBsZDGdDVwm+hPaAnGXNu+9del6rvLU2MzJNt+ueWkbfn5sEA0Sd2cb86gOjWSCpJg/U
         crf1ISLOIiQw9kbM4+WwGDyNKNpMMbTaTBVj0yhNsDAZLVZkat/VBSCzm7iUNa40GKAP
         vySw==
X-Gm-Message-State: AOAM531ZHIkI69Vc1/D1zWpXpU2wAMThDqgrh2iQQqoi9TcHiLfRxK0Q
        O1tKZR3qQrQKoYEZFhDj17gWUwE54QO2a0p34BQgjpBv/IA15b2mVNRQoVjzb6fJW1kkf0urtpH
        QHP8gYt0tvaaFfSnbAXO7QWAVpPBOMn3TnTY7V4vmzvMlLgva3tFOfior7pFPIhTRCRTr
X-Received: by 2002:a05:6214:7cf:: with SMTP id bb15mr4351667qvb.29.1626355113273;
        Thu, 15 Jul 2021 06:18:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvOYGQHwP4m9K0OvynsEmDNkxDs2xY5R/rJGf0uAm0tyiz1L5gf7DU/xLnn7JerWoBsO1R8w==
X-Received: by 2002:a05:6214:7cf:: with SMTP id bb15mr4351636qvb.29.1626355112992;
        Thu, 15 Jul 2021 06:18:32 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d25sm2005088qtw.59.2021.07.15.06.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 06:18:31 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: fpga: convert Xilinx Zynq MPSoC bindings to
 YAML
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, robh+dt@kernel.org,
        michal.simek@xilinx.com, mdf@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20210715100236.228531-1-iwamatsu@nigauri.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <f78e471c-8f08-4ef6-667b-1c8484baf60a@redhat.com>
Date:   Thu, 15 Jul 2021 06:18:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210715100236.228531-1-iwamatsu@nigauri.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 7/15/21 3:02 AM, Nobuhiro Iwamatsu wrote:
> Convert FPGA Manager for Xilinx Zynq MPSoC bindings documentation to
> YAML.
>
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>   .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   | 25 -------------
>   .../bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml  | 36 +++++++++++++++++++
>   2 files changed, 36 insertions(+), 25 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
>   create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml
>
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> deleted file mode 100644
> index 3052bf619dd547..00000000000000
> --- a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -Devicetree bindings for Zynq Ultrascale MPSoC FPGA Manager.
> -The ZynqMP SoC uses the PCAP (Processor configuration Port) to configure the
> -Programmable Logic (PL). The configuration uses  the firmware interface.
> -
> -Required properties:
> -- compatible: should contain "xlnx,zynqmp-pcap-fpga"
> -
> -Example for full FPGA configuration:
> -
> -	fpga-region0 {
> -		compatible = "fpga-region";
> -		fpga-mgr = <&zynqmp_pcap>;
> -		#address-cells = <0x1>;
> -		#size-cells = <0x1>;
> -	};
> -
> -	firmware {
> -		zynqmp_firmware: zynqmp-firmware {
> -			compatible = "xlnx,zynqmp-firmware";
> -			method = "smc";
> -			zynqmp_pcap: pcap {
> -				compatible = "xlnx,zynqmp-pcap-fpga";
> -			};
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml
> new file mode 100644
> index 00000000000000..565b835b7fbac0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/xlnx,zynqmp-pcap-fpga.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx Zynq Ultrascale MPSoC FPGA Manager Device Tree Bindings
> +
> +maintainers:
> +  - Michal Simek <michal.simek@xilinx.com>
Needs a change to MAINTAINERS ?
> +
> +description: |
> +  Device Tree Bindings for Zynq Ultrascale MPSoC FPGA Manager.
> +  The ZynqMP SoC uses the PCAP (Processor configuration Port) to

Configuration

Tom

> +  configure the Programmable Logic (PL). The configuration uses the
> +  firmware interface.
> +
> +properties:
> +  compatible:
> +    const: xlnx,zynqmp-pcap-fpga
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    firmware {
> +      zynqmp_firmware: zynqmp-firmware {
> +        zynqmp_pcap: pcap {
> +          compatible = "xlnx,zynqmp-pcap-fpga";
> +        };
> +      };
> +    };
> +...

