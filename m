Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC22C0834
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Sep 2019 17:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfI0PBR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 27 Sep 2019 11:01:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38269 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbfI0PBR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 27 Sep 2019 11:01:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id h195so1754419pfe.5
        for <linux-fpga@vger.kernel.org>; Fri, 27 Sep 2019 08:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iwywjeDVM8AUXGeKWR8/wgyVViur6euGe/EV6CXLnA4=;
        b=cDlSGKRKC6fbopE4DttTQwjq7yn4CUhnlqDd4QtSDpWNKr6wFEd6LbAg32dFf2ncmv
         OKtrCCctNNIoW2s6W0pvtmJOco8IjQ2OD1lexCjGksQXp2aR7aoqmv7o4jYn2zABndHl
         dWT0HqOiStrRQ66a1sEsk0wxIQCUPurEcRmD0Sts5m8SgKmX8Cz8deLRWE8gsZWz2xIv
         yanQY7bTrn1woobVLcib04JWFe3/x9dKfeoM4HHyUs7Yf2q0swUdJv5aG/ldkSHMxKfM
         6x92DLydqbELKSag+z87tkJPiEMylEuCH2aK71TGKcd2WvW/FCdsDcozZt/AFtNanYc3
         53bw==
X-Gm-Message-State: APjAAAXRaihlWDsUTf2g6CjA4ri08ewYik3Kmi11f4xXcxyy1XhkhtzR
        iVxnX1rLqDSYVmIOlfztWNJGnA==
X-Google-Smtp-Source: APXvYqxCiNCa9+/WHmk6ynVp+bPUVj9CZfNwljUVZCSHmmBcwDkub/iysw40+Wm+iTSfFTH0pY7V8g==
X-Received: by 2002:a62:1cd2:: with SMTP id c201mr4896904pfc.51.1569596476331;
        Fri, 27 Sep 2019 08:01:16 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id x68sm3785991pfd.183.2019.09.27.08.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 08:01:15 -0700 (PDT)
Date:   Fri, 27 Sep 2019 08:01:14 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/3] include: fpga: adi-axi-common: Define version macros
Message-ID: <20190927150114.GA2146@archbox>
References: <20190926103925.194973-1-nuno.sa@analog.com>
 <20190926103925.194973-2-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190926103925.194973-2-nuno.sa@analog.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Nuno,

On Thu, Sep 26, 2019 at 12:39:23PM +0200, Nuno Sá wrote:
> Add commom macros to "parse" ADI HDL cores version, in terms of
> major, minor and patch.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  include/linux/fpga/adi-axi-common.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/fpga/adi-axi-common.h
> index 7fc95d5c95bb..5bc5603e6bc8 100644
> --- a/include/linux/fpga/adi-axi-common.h
> +++ b/include/linux/fpga/adi-axi-common.h
> @@ -16,4 +16,8 @@
>  #define ADI_AXI_PCORE_VER(major, minor, patch)	\
>  	(((major) << 16) | ((minor) << 8) | (patch))
>  
> +#define ADI_AXI_PCORE_VER_MAJOR(version)	(((version) >> 16) & 0xff)
> +#define ADI_AXI_PCORE_VER_MINOR(version)	(((version) >> 8) & 0xff)
> +#define ADI_AXI_PCORE_VER_PATCH(version)	((version) & 0xff)
> +
>  #endif /* ADI_AXI_COMMON_H_ */
> -- 
> 2.23.0
> 

While implemented in an FPGA I'm not sure if this needs to go into
includelinux/fpga/.

I'd suggest to add this to the actual driver for now, and once you have
multiple users you can find a common location.

Cheers,
Moritz
