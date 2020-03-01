Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A698D174E5D
	for <lists+linux-fpga@lfdr.de>; Sun,  1 Mar 2020 17:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgCAQWr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fpga@lfdr.de>); Sun, 1 Mar 2020 11:22:47 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:36420 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgCAQWr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 1 Mar 2020 11:22:47 -0500
Received: by mail-pf1-f181.google.com with SMTP id i13so4328350pfe.3;
        Sun, 01 Mar 2020 08:22:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RC6gqsxmlr/uPyqKDFjSYPeDRepo1Y68M1WdWsW653c=;
        b=Wq9hrL6YtNVlkl5pqZjmxtNbqmROV/5CEWu460FgmvAg3N2cyvzdzEL/q/LQULk4aD
         7aL0zCBi+mOIk4OY8piaYoail/EM8owwfdTMhVjOoEAAzoO2WEME/Sc7KzB8dxd9n6PW
         0j/Vsvq+dZheFsWWgyF9I029RqdgPsQibZWneq6yn/j1qJR6omPg/h9akR0bF6+pOVsM
         Ujrgj+7DBEAfM3HHlGC9O/YODvrLwAWYyoVPT9V0X+NnEjpbjyJo9mJdwj+LyL9pdxai
         bKQbLS8YuWskoZuPNaJT2uPhFySaRPSTbxjI1fhqG+tcxgsU9Kx/6QJAt6mblzVhKDd2
         JfxA==
X-Gm-Message-State: APjAAAVtFk2bmtR9rRQDvHZhWjJbrYoONyE/r5jz1+sBxHeuALZLTO/v
        ZN0DAT6BlPdwzscyHLKTmoA=
X-Google-Smtp-Source: APXvYqyeDgI37eyw4PvvQ06Em4Bam3ujM0H8U7YeHZuchndlQaSGMx6T1ZCDgTYMyCMX6a6Cis8wag==
X-Received: by 2002:a63:f925:: with SMTP id h37mr12173211pgi.103.1583079766487;
        Sun, 01 Mar 2020 08:22:46 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:c2fa:3aa3:193c:db86])
        by smtp.gmail.com with ESMTPSA id e28sm17680263pgn.21.2020.03.01.08.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 08:22:45 -0800 (PST)
Date:   Sun, 1 Mar 2020 08:22:44 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     richard.gong@linux.intel.com
Cc:     gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv1 4/7] dt-bindings, firmware: add compatible value Intel
 Stratix10 service layer binding
Message-ID: <20200301162244.GC7593@epycbox.lan>
References: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
 <1581696052-11540-5-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1581696052-11540-5-git-send-email-richard.gong@linux.intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Feb 14, 2020 at 10:00:49AM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> A a compatible property value to Intel Stratix10 service layer binding
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
> index 1fa6606..6eff1af 100644
> --- a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
> +++ b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
> @@ -23,7 +23,7 @@ Required properties:
>  The svc node has the following mandatory properties, must be located under
>  the firmware node.
>  
> -- compatible: "intel,stratix10-svc"
> +- compatible: "intel,stratix10-svc" or "intel,agilex-svc"
>  - method: smc or hvc
>          smc - Secure Monitor Call
>          hvc - Hypervisor Call
> -- 
> 2.7.4
> 
Applied to for-next,

Thanks
