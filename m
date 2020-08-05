Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE0A23D2C4
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Aug 2020 22:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbgHEUP7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Aug 2020 16:15:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48070 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726401AbgHEQUE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 5 Aug 2020 12:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596644402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QVpgCBuAAnsCtvrERYgdCRjC/scatHyJclE27/3mCkw=;
        b=U2q5APabxjsEKq4IeTyjVbVa1zfiROltSQvSgmQQczhoWDuzbCspTluLh+za2kp/sZu6Pm
        vp04LkpXuKJ8zTAzZI/gQIffdFZqq8SlIq0THL0HbRqOdcKYxZh3xH5mWeKzrTc1piSirk
        jWnLrh6YZ5H3a1kq949/pMVNfIRqeN8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-nc31Qv6YNzyDevaKdVlxpQ-1; Wed, 05 Aug 2020 12:02:13 -0400
X-MC-Unique: nc31Qv6YNzyDevaKdVlxpQ-1
Received: by mail-qt1-f199.google.com with SMTP id e14so24494434qtm.5
        for <linux-fpga@vger.kernel.org>; Wed, 05 Aug 2020 09:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QVpgCBuAAnsCtvrERYgdCRjC/scatHyJclE27/3mCkw=;
        b=Z7UPlXr3swBgVHq48iG+iX0tkHKCdMp6+ZHerUKqnMLA2+5/Hct+krj9RdSdQLv8eG
         YYedq+iLrSQNqFH+AGGltvNUXe32RtI9o3jesKHpRcq2wc/JJ2GVJXowfpw0RcS2yeEz
         48q7vpyx3nzc93/5/mh0/uIRb7CEHiSHVRfZPfKFNONC3nIEfU0h3z2R+kpMkpUZGbaG
         g3hFKTCbkVX+O4HW1jGQ2eY+WRK3t2TFMquC7WHu2t5c1AWEgpVoAvgpkIsKqBsq6TWF
         td++/CwQ4RscNNso+E0jl/ORT/ttOmyD4WLdbt7DWcQvo/g4YnG/FjGeYxKDzANsoK9R
         2N3w==
X-Gm-Message-State: AOAM533ToOneBUyccj1tbQgKtnuZstgs3F+1Z/bKgPrfMpQ453BAUmZd
        wB5qtuw99y4OBBdzFKV66QIKUZk0mUaYLglNpaEdZxClQNmlbxVX898+94Sr0Wq0tPLoJTPzpy6
        HS6/kOYAfGfFhNpEoS+LZ7w==
X-Received: by 2002:ad4:554f:: with SMTP id v15mr4340220qvy.30.1596643333039;
        Wed, 05 Aug 2020 09:02:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCEt6SOCQIQNlgWFc2fSlY6oagtplzPU3BVLGyxoUjfFLo9zIHh0cZuAl1swq7IdMfrOOlkw==
X-Received: by 2002:ad4:554f:: with SMTP id v15mr4340183qvy.30.1596643332734;
        Wed, 05 Aug 2020 09:02:12 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d46sm2548270qtk.37.2020.08.05.09.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 09:02:12 -0700 (PDT)
Subject: Re: [PATCH 5/6] include: fpga: adi-axi-common.h: add definitions for
 supported FPGAs
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, mdf@kernel.org,
        Mircea Caprioru <mircea.caprioru@analog.com>
References: <20200804110658.40911-1-alexandru.ardelean@analog.com>
 <20200804110658.40911-6-alexandru.ardelean@analog.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <f69c3dc7-be50-9685-b70f-8af2f7093646@redhat.com>
Date:   Wed, 5 Aug 2020 09:02:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200804110658.40911-6-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 8/4/20 4:06 AM, Alexandru Ardelean wrote:
> From: Mircea Caprioru <mircea.caprioru@analog.com>
>
> All (newer) FPGA IP cores supported by Analog Devices, store information in
> the synthesized designs. This information describes various parameters,
> including the family of boards on which this is deployed, speed-grade, and
> so on.
>
> Currently, some of these definitions are deployed mostly on Xilinx boards,
> but they have been considered also for FPGA boards from other vendors.
>
> The register definitions are described at this link:
>   https://wiki.analog.com/resources/fpga/docs/hdl/regmap
> (the 'Base (common to all cores)' section).
>
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  include/linux/fpga/adi-axi-common.h | 37 +++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/fpga/adi-axi-common.h
> index 141ac3f251e6..7cca2d62cc45 100644
> --- a/include/linux/fpga/adi-axi-common.h
> +++ b/include/linux/fpga/adi-axi-common.h
> @@ -13,6 +13,9 @@
>  
>  #define ADI_AXI_REG_VERSION			0x0000
>  
> +#define ADI_AXI_REG_FPGA_INFO			0x001C
> +#define ADI_AXI_REG_FPGA_VOLTAGE		0x0140
> +
>  #define ADI_AXI_PCORE_VER(major, minor, patch)	\
>  	(((major) << 16) | ((minor) << 8) | (patch))
>  
> @@ -20,4 +23,38 @@
>  #define ADI_AXI_PCORE_VER_MINOR(version)	(((version) >> 8) & 0xff)
>  #define ADI_AXI_PCORE_VER_PATCH(version)	((version) & 0xff)
>  
> +#define ADI_AXI_INFO_FPGA_VOLTAGE(val)		((val) & 0xffff)
> +
> +#define ADI_AXI_INFO_FPGA_TECH(info)		(((info) >> 24) & 0xff)
> +#define ADI_AXI_INFO_FPGA_FAMILY(info)		(((info) >> 16) & 0xff)
> +#define ADI_AXI_INFO_FPGA_SPEED_GRADE(info)	(((info) >> 8) & 0xff)
> +
> +enum adi_axi_fgpa_technology {

enum types are defined but not used.  It would be better to convert all of these to #defines.

These are only the Xilinx values. Need to add the Intel values from

https://github.com/analogdevicesinc/hdl/blob/master/library/scripts/adi_intel_device_info_enc.tcl

The #define names need to include XILINX or INTEL.

Tom

> +	ADI_AXI_FPGA_TECH_UNKNOWN = 0,
> +	ADI_AXI_FPGA_TECH_SERIES7,
> +	ADI_AXI_FPGA_TECH_ULTRASCALE,
> +	ADI_AXI_FPGA_TECH_ULTRASCALE_PLUS,
> +};
> +
> +enum adi_axi_fpga_family {
> +	ADI_AXI_FPGA_FAMILY_UNKNOWN = 0,
> +	ADI_AXI_FPGA_FAMILY_ARTIX,
> +	ADI_AXI_FPGA_FAMILY_KINTEX,
> +	ADI_AXI_FPGA_FAMILY_VIRTEX,
> +	ADI_AXI_FPGA_FAMILY_ZYNQ,
> +};
> +
> +enum adi_axi_fpga_speed_grade {
> +	ADI_AXI_FPGA_SPEED_UNKNOWN	= 0,
> +	ADI_AXI_FPGA_SPEED_1		= 10,
> +	ADI_AXI_FPGA_SPEED_1L		= 11,
> +	ADI_AXI_FPGA_SPEED_1H		= 12,
> +	ADI_AXI_FPGA_SPEED_1HV		= 13,
> +	ADI_AXI_FPGA_SPEED_1LV		= 14,
> +	ADI_AXI_FPGA_SPEED_2		= 20,
> +	ADI_AXI_FPGA_SPEED_2L		= 21,
> +	ADI_AXI_FPGA_SPEED_2LV		= 22,
> +	ADI_AXI_FPGA_SPEED_3		= 30,
> +};
> +
>  #endif /* ADI_AXI_COMMON_H_ */

