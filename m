Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C76BA16EC85
	for <lists+linux-fpga@lfdr.de>; Tue, 25 Feb 2020 18:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbgBYR3J (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 25 Feb 2020 12:29:09 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:38809 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730427AbgBYR3J (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 25 Feb 2020 12:29:09 -0500
Received: by mail-oi1-f180.google.com with SMTP id r137so96254oie.5;
        Tue, 25 Feb 2020 09:29:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i9WEf1lopTCh9mdPytEzlIgO8LHEQJZa98yyLvLlAnU=;
        b=YGdatUY6i4BnMbFHinnrw6EPSeFhMB5PxvaOQ6+8XAcxwsFYc4PA/z+C6zkMQtktQg
         scSUQB1jjKlppomho99EwKbWz7zcJ/7IZ4CTfdkP48IF/FCuplIh1oKgbWl7mS25XqK4
         zaYjqum/HHzh8MQ7IfldC+ubzsRDm0RMrrYvjRHLcDmn+CFWAZB3n1xGHRXikbE6KXoD
         2WFZRART+BLQJSDL0BPa5b0FDYqBu/4CC53bge7T4wpyRFUh3umCwbHnk5McU+1S2ljf
         BfLAch5AQf7GBTODau97Lh/PsuClWIbFlzCEQe56J/YzDc3/zEEwlmXRm8RkhTsDfyCT
         vDuw==
X-Gm-Message-State: APjAAAWAo8MsInj4SsXcXHH4wB5mQ+gKayl62L5WVm21gv4XmFQEcYVX
        lXvGNCZfENIzpNeH0XiYbw==
X-Google-Smtp-Source: APXvYqzgsk4urqoB9f9mZtdmWpTL+TsxcDZcfRf6WQFt93aPBTQJUvh5VIyWcFQZlnJ5HpZnb1J2xQ==
X-Received: by 2002:aca:c514:: with SMTP id v20mr61682oif.62.1582651748014;
        Tue, 25 Feb 2020 09:29:08 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m18sm5848296otf.6.2020.02.25.09.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 09:29:07 -0800 (PST)
Received: (nullmailer pid 31776 invoked by uid 1000);
        Tue, 25 Feb 2020 17:29:06 -0000
Date:   Tue, 25 Feb 2020 11:29:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     richard.gong@linux.intel.com
Cc:     gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, richard.gong@linux.intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv1 4/7] dt-bindings, firmware: add compatible value Intel
 Stratix10 service layer binding
Message-ID: <20200225172906.GA31720@bogus>
References: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
 <1581696052-11540-5-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581696052-11540-5-git-send-email-richard.gong@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, 14 Feb 2020 10:00:49 -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> A a compatible property value to Intel Stratix10 service layer binding
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
