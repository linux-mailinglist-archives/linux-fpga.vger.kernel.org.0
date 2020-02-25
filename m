Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDAF916EC80
	for <lists+linux-fpga@lfdr.de>; Tue, 25 Feb 2020 18:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbgBYR1h (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 25 Feb 2020 12:27:37 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:33012 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbgBYR1h (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 25 Feb 2020 12:27:37 -0500
Received: by mail-oi1-f172.google.com with SMTP id q81so120267oig.0;
        Tue, 25 Feb 2020 09:27:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ebAN88jVZ70OZv/ZiSU6793X1uKdNcuYESO2iPOfVaw=;
        b=SaboRLcHnqLOYEAl/QU0TqVW6CdodpSmtWVGW72TJ1Wum9gMsaxXKgmmw9IL1MnTuH
         SrDSbPT5Tr/Ka+MNiOC/aL0aKFvJRf3nENfOeb13jHFhE7bjIs+8MboT8r9XANwHSj1x
         QUWPR7RK0lY9vG5pV25A/wGqAcQBgTF/LNmns2FbSv6IuKbh44TDAuLf4tJeY0jiklmr
         O0b77NIBx7YWIxuPh/uG3OvNCT8kbZsI7XWzRlYmZh4LCXT74TNYTkkVZzk43LNADnmV
         ez0gQTnjVOMMzNJuYDVbUaRjXvBG5KWeMjaZPKrxq2PSUDU8/7cTzCsJgtpNOPEfFgvc
         klyg==
X-Gm-Message-State: APjAAAW0PWxsrWbm/J38h62sCwWGjCzSKLMPMe9QLAIgVSGbbYTyiK8/
        zKrGWIi3naXrHO1g5FHcXQ==
X-Google-Smtp-Source: APXvYqxKdXjLhhTfBoU5bclLJIrauIz7kg2W3zD/IxQzo8vji39As2vKYYVeyXaDJd1U5ojWwtMUJQ==
X-Received: by 2002:a05:6808:618:: with SMTP id y24mr49994oih.86.1582651656206;
        Tue, 25 Feb 2020 09:27:36 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i13sm5380358oik.7.2020.02.25.09.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 09:27:35 -0800 (PST)
Received: (nullmailer pid 29505 invoked by uid 1000);
        Tue, 25 Feb 2020 17:27:34 -0000
Date:   Tue, 25 Feb 2020 11:27:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     richard.gong@linux.intel.com
Cc:     gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, richard.gong@linux.intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv1 1/7] dt-bindings: fpga: add compatible value to
 Stratix10 SoC FPGA manager binding
Message-ID: <20200225172734.GA29404@bogus>
References: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
 <1581696052-11540-2-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581696052-11540-2-git-send-email-richard.gong@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, 14 Feb 2020 10:00:46 -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Add a compatible property value to Stratix10 SoC FPGA manager binding file
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  .../devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt          | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
