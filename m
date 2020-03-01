Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F32AF174E75
	for <lists+linux-fpga@lfdr.de>; Sun,  1 Mar 2020 17:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCAQ0n (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 1 Mar 2020 11:26:43 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36533 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgCAQ0n (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 1 Mar 2020 11:26:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id g12so1180570plo.3;
        Sun, 01 Mar 2020 08:26:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X7zxxhgHbKLDitd/8pwwrybHJl2ebla3PsVr9XveOPE=;
        b=ehFvhi2HfDA7iwAplHkdLgI/ndQ64YePjxiv1YE4FYgg6c36ORcKrL+BIQ3S4HGzel
         oI5VM8QBtkwD+CI7gzkVEpgtRvbJy+9JfLIL8c67pF8WT703I+1ZSmevYoylZ2TeEdEo
         SDkGWjd3uU76htC7Li2Q+Tk6exmF6+nHMOk2isOIFDzyueAWcUo/1THOaA10F8bLGuaD
         8305yBECUFOhFRW9RsglGHe06xM05i+JaEV+fL2LSg2SnhSAe2gEWL5eYofrH9B5P2vy
         oTh03jSIdIzFkFFLUmYS2aiKbfqEjvrBL+fF4OXOYT3DHUwzwIOShHTbs5Hqes0yhjEI
         +Iow==
X-Gm-Message-State: ANhLgQ22s+egmIk6zLOCLUS43+U4tnJmKTPv/Y+aTrURsB2DXi1qdIAj
        2laEa6/bD3VwGGtg8TWyvv4Rr8GkzUE=
X-Google-Smtp-Source: ADFU+vsmL4VCAnuyLcIDF618gVDP+uBDmnHopShPkg/C1O0bJ2GDJhk9Z4Gr3Wg9ndeW6DbXCvE+Yg==
X-Received: by 2002:a17:90a:bd90:: with SMTP id z16mr2090729pjr.36.1583080002408;
        Sun, 01 Mar 2020 08:26:42 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:c2fa:3aa3:193c:db86])
        by smtp.gmail.com with ESMTPSA id l4sm9066313pje.27.2020.03.01.08.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 08:26:41 -0800 (PST)
Date:   Sun, 1 Mar 2020 08:26:40 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     richard.gong@linux.intel.com
Cc:     gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv1 5/7] arm64: dts: agilex: correct service layer driver's
 compatible value
Message-ID: <20200301162640.GH7593@epycbox.lan>
References: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
 <1581696052-11540-6-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581696052-11540-6-git-send-email-richard.gong@linux.intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Feb 14, 2020 at 10:00:50AM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Correct the compatible property value for Intel Service Layer driver
> on Intel Agilex SoC platform.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> index 8c29853..d48218c 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> @@ -539,7 +539,7 @@
>  
>  		firmware {
>  			svc {
> -				compatible = "intel,stratix10-svc";
> +				compatible = "intel,agilex-svc";
>  				method = "smc";
>  				memory-region = <&service_reserved>;
>  
> -- 
> 2.7.4
> 
Applied to for-next,

Thanks
