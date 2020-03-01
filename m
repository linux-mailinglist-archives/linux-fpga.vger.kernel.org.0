Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC53174E60
	for <lists+linux-fpga@lfdr.de>; Sun,  1 Mar 2020 17:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCAQXF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 1 Mar 2020 11:23:05 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37308 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgCAQXE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 1 Mar 2020 11:23:04 -0500
Received: by mail-pj1-f66.google.com with SMTP id o2so1435339pjp.2;
        Sun, 01 Mar 2020 08:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qFG7x7PAuJkU4tNySbcaHEYqhAMJ6Q2G5x0nlihs+lY=;
        b=bksqbwq9oR+b/6RcIErELAiNRZCQAcW64adUmLpHODP8nokNNrGg5HKfLVwSpnoDZ3
         DDLQXAcQto3gAYBlIZ7FjJ6zCm+MrKhX/bbsT33JrAMTjJtw87W40krn0VAR43s6iijD
         Y18dCyQeStYht5giSW6I2NcQMjsqsvSqX56VUT8o2A47EQVQzChVf5Nvp9QWm1PtPX96
         1Ol2jRxihiDlhLWRqwfcoDPJdUQmHyXOUvzClCR7c8ezuO2tmf6cNt9z1iWansTS+l/M
         Ii4qhUBHh9QuGbpOnZM+WRQG3i1bW0HGrj/9jvG3NH8XB2Hje9JRl7fg96EqAeXiPEE0
         z/dQ==
X-Gm-Message-State: APjAAAUrOwyfd/GERKhoau7swHYqgKUMFRAvjdgcW6OLlXujrI+SEMu+
        ZPjikgFuvayYNbux8KJoU5A=
X-Google-Smtp-Source: APXvYqyGAoj8cGocMbcFj1K2p+VTnQjwdVy2CFaXZmLleFqEiiQYlZSukdtM/J+3vEgpuKHSPD2Xww==
X-Received: by 2002:a17:90a:1b22:: with SMTP id q31mr15312984pjq.106.1583079783795;
        Sun, 01 Mar 2020 08:23:03 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:c2fa:3aa3:193c:db86])
        by smtp.gmail.com with ESMTPSA id 7sm6144986pfg.12.2020.03.01.08.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 08:23:03 -0800 (PST)
Date:   Sun, 1 Mar 2020 08:23:02 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     richard.gong@linux.intel.com
Cc:     gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv1 1/7] dt-bindings: fpga: add compatible value to
 Stratix10 SoC FPGA manager binding
Message-ID: <20200301162302.GD7593@epycbox.lan>
References: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
 <1581696052-11540-2-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581696052-11540-2-git-send-email-richard.gong@linux.intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Feb 14, 2020 at 10:00:46AM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Add a compatible property value to Stratix10 SoC FPGA manager binding file
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  .../devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt          | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
> index 6e03f79..0f87413 100644
> --- a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
> +++ b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
> @@ -4,7 +4,8 @@ Required properties:
>  The fpga_mgr node has the following mandatory property, must be located under
>  firmware/svc node.
>  
> -- compatible : should contain "intel,stratix10-soc-fpga-mgr"
> +- compatible : should contain "intel,stratix10-soc-fpga-mgr" or
> +	       "intel,agilex-soc-fpga-mgr"
>  
>  Example:
>  
> -- 
> 2.7.4
> 
Applied to for-next,

Thanks
