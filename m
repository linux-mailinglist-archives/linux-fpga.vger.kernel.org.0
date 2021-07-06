Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055CE3BDEC0
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Jul 2021 23:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhGFVLr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Jul 2021 17:11:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33711 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229879AbhGFVLr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Jul 2021 17:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625605747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KBq+Giaoz3hgDlNlhhTm/jlI5hfT1qo7ZASPTogNz/Q=;
        b=c1SGu5xsUzCShc2/RFsnOU1I3fHrRctFFpWBNo3RaKrC+uQ2j3lDsriA/kCry2lDgTnPxF
        9EtKgE6nEPH02fGAXUgXVBp+uHuBg2bzFUbk7sJPIH9IBc+4mfQk8P2Vy2uBLjN6yk6bjf
        h1WurIjks/FqrgMBdCqfd9XGzFX3U1Y=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-Y9VWc65-MLqRgU9hxND5tA-1; Tue, 06 Jul 2021 17:09:06 -0400
X-MC-Unique: Y9VWc65-MLqRgU9hxND5tA-1
Received: by mail-oo1-f69.google.com with SMTP id s11-20020a4ac10b0000b029024bc69d2a8aso11214648oop.16
        for <linux-fpga@vger.kernel.org>; Tue, 06 Jul 2021 14:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KBq+Giaoz3hgDlNlhhTm/jlI5hfT1qo7ZASPTogNz/Q=;
        b=gsHvpunYZYbr1BIyILJL6gCtUUSjBBXPaotO+byzAoz7SJEZz13opD0C9IuqWL9p+m
         gk0aC0xoZ1Sk7Q5RMOgxB3WQ6T66oUV0WhWfxEQg/aDHZ9uKSkVNwv+IkQsvJjONsI9g
         7RtkCpFGTJ5En5R8vCt93Jntl723SCTvctJVpiqUN44R4KF3sEVeJHbXH56iJsbS3ps3
         xiCP0OTQ9xke//V3aQgnj1J4qfxNXMLzp4gWkVnirT1swajoOvgFtdqkEg4GY5TjMbb9
         27WYfctyXpFJtY+NplHwvPfhzHcrB9fl8PdYzuWjMU7sLQMAJoKge9qyDdmXVOjn6BV0
         Hp7w==
X-Gm-Message-State: AOAM532TiyJgq4j+0KMFCOWVdn3xvn/pa14oG59cjN1OxC5CA0xuQhIn
        RyXQmllZbMEX15F8VlD0c53r9u7qknocuaiR1u++Dcs3/+ovJ41JOqQ9UpKkrwD35lu+ciM4Fk5
        RYbBM2xU0MEMJlNrAQnT60A==
X-Received: by 2002:a9d:19c1:: with SMTP id k59mr16511351otk.172.1625605745637;
        Tue, 06 Jul 2021 14:09:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxk4J/5k+hZaRqOe7DiEQdTLOYWgGDrZytbu3TZBL4euG3qmbddzWCvvzY2VZzrTnwph+BIPA==
X-Received: by 2002:a9d:19c1:: with SMTP id k59mr16511339otk.172.1625605745493;
        Tue, 06 Jul 2021 14:09:05 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 76sm1521355otj.28.2021.07.06.14.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 14:09:05 -0700 (PDT)
Subject: Re: [PATCH v8 4/5] dt-bindings: firmware: Remove
 xlnx,zynqmp-firmware.txt file
To:     Nava kishore Manne <nava.manne@xilinx.com>, robh+dt@kernel.org,
        michal.simek@xilinx.com, mdf@kernel.org, arnd@arndb.de,
        rajan.vaja@xilinx.com, gregkh@linuxfoundation.org,
        amit.sunil.dhamne@xilinx.com, tejas.patel@xilinx.com,
        zou_wei@huawei.com, lakshmi.sai.krishna.potthuri@xilinx.com,
        ravi.patel@xilinx.com, iwamatsu@nigauri.org,
        wendy.liang@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, git@xilinx.com,
        chinnikishore369@gmail.com
References: <20210626155248.5004-1-nava.manne@xilinx.com>
 <20210626155248.5004-5-nava.manne@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <a2a71d30-97da-0b1e-7942-f7dd63b0ddab@redhat.com>
Date:   Tue, 6 Jul 2021 14:09:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210626155248.5004-5-nava.manne@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 6/26/21 8:52 AM, Nava kishore Manne wrote:
> The funtionality of xlnx,zynqmp-firmware.txt is replaced with

functionality

Tom

> xlnx,zynqmp-firmware.yaml bindings so this patch removes the
> zynqmp-firmware.txt file
>
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v8:
>                -Removed xlnx,zynqmp-firmware.txt as suggested by rob.
>
>   .../firmware/xilinx/xlnx,zynqmp-firmware.txt  | 44 -------------------
>   1 file changed, 44 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
>
> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> deleted file mode 100644
> index 18c3aea90df2..000000000000
> --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> +++ /dev/null
> @@ -1,44 +0,0 @@
> ------------------------------------------------------------------
> -Device Tree Bindings for the Xilinx Zynq MPSoC Firmware Interface
> ------------------------------------------------------------------
> -
> -The zynqmp-firmware node describes the interface to platform firmware.
> -ZynqMP has an interface to communicate with secure firmware. Firmware
> -driver provides an interface to firmware APIs. Interface APIs can be
> -used by any driver to communicate to PMUFW(Platform Management Unit).
> -These requests include clock management, pin control, device control,
> -power management service, FPGA service and other platform management
> -services.
> -
> -Required properties:
> - - compatible:	Must contain any of below:
> -		"xlnx,zynqmp-firmware" for Zynq Ultrascale+ MPSoC
> -		"xlnx,versal-firmware" for Versal
> - - method:	The method of calling the PM-API firmware layer.
> -		Permitted values are:
> -		  - "smc" : SMC #0, following the SMCCC
> -		  - "hvc" : HVC #0, following the SMCCC
> -
> --------
> -Example
> --------
> -
> -Zynq Ultrascale+ MPSoC
> -----------------------
> -firmware {
> -	zynqmp_firmware: zynqmp-firmware {
> -		compatible = "xlnx,zynqmp-firmware";
> -		method = "smc";
> -		...
> -	};
> -};
> -
> -Versal
> -------
> -firmware {
> -	versal_firmware: versal-firmware {
> -		compatible = "xlnx,versal-firmware";
> -		method = "smc";
> -		...
> -	};
> -};

