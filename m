Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FAB37FB01
	for <lists+linux-fpga@lfdr.de>; Thu, 13 May 2021 17:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhEMPuO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 13 May 2021 11:50:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21495 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230398AbhEMPuN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 13 May 2021 11:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620920943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OXFg9yT+SRP4aJjvJsKPgnXEZ8W+KPtuhwXQgp0wnKU=;
        b=MB4mmajmb3I8VtS26f7BMKuIvcFeL3WI+YMCAwrlRcXQ63rj+Tgd898W8C6pGUCstzFI2M
        QN508vgjDqRBUNAxBhYSuSLtkl/6T2bOkO+lKHUYOEXaZ8e1kLkOqpiyyyr0+2z3KYXJcA
        u0Qy5g01DCRwYML0EWoNw4BPbOa0b3A=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-Yb1_cEjvMjm2nTvcmc3fAg-1; Thu, 13 May 2021 11:49:01 -0400
X-MC-Unique: Yb1_cEjvMjm2nTvcmc3fAg-1
Received: by mail-qt1-f198.google.com with SMTP id g21-20020ac86f150000b02901c94e794dd7so18184490qtv.7
        for <linux-fpga@vger.kernel.org>; Thu, 13 May 2021 08:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OXFg9yT+SRP4aJjvJsKPgnXEZ8W+KPtuhwXQgp0wnKU=;
        b=KUHUSvbIcJVwFULfFNTpRI7svVw91e0qQQhvSagpk0+X9C1UFkPA5+8UTWbYw2Jbmi
         ++q/j4jTBmrlebmal2Z8Z1b9W3p5eIzL1VxTQq1LivrHwTtL7t9ggfNbGBbJENaNwacx
         TbhBqN1r1B+iP+3OQhPEbUkCJVPEeRJbAsugOMUQN7PoNVYMFx+7HtE2e0MNg2wur+M4
         QGSGQ/j3Ja0lgXFa24ZclvvTpVKIvpZveYRxdMzfOkwKHxvCoXfE7oiC6vIi4aNcFdW3
         uXqCt+P8wVj7NXD9gzgBe/L4jsGobqopFU3n05Zx42GE7GjnXZAb8uEU6M9HBvnK6LOi
         0Eew==
X-Gm-Message-State: AOAM530COi9Nox0yyCR4qKYc3fIt0aUpwtUsFYSVg+feiYekhLW75jdP
        iX8WcRHUThb6X0IpERD18c9DPW4Z7F5g6CfkUXb/UNehLCh+yO/9AKQrc/yjhJJRckt904KOPXW
        Tr5tjmQqODSVm0ybFE7FaWQ==
X-Received: by 2002:a37:98c4:: with SMTP id a187mr38940512qke.277.1620920941060;
        Thu, 13 May 2021 08:49:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUyK6JS8Fjz7RmzsmXIRnyG/yAEecKiFii/ajYNOLBY3TFUJO/jJ58x9Xer/nE8I7bMnTXWw==
X-Received: by 2002:a37:98c4:: with SMTP id a187mr38940499qke.277.1620920940893;
        Thu, 13 May 2021 08:49:00 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 195sm2645020qkj.1.2021.05.13.08.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 08:49:00 -0700 (PDT)
Subject: Re: [PATCH V6 XRT Alveo 16/20] fpga: xrt: clock driver
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210512015339.5649-1-lizhi.hou@xilinx.com>
 <20210512015339.5649-17-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <f4a18fa4-f023-d4e5-0622-e15108de90b9@redhat.com>
Date:   Thu, 13 May 2021 08:48:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512015339.5649-17-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> +
> +static int get_freq(struct clock *clock, u16 *freq)
> +{

> +
> +	/*
> +	 * Multiply both numerator (mul0) and the denominator (div1) with
> +	 * 1000 to account for fractional portion of divider
> +	 */
> +
> +	div1 *= 1000;
> +	div1 += div_frac1;
> +	div0 *= div1;
> +	mul0 *= 1000;
> +	if (div0 == 0) {
> +		CLOCK_ERR(clock, "clockwiz 0 divider");

This prevents a divide by zero, but returns 0 without setting freq

A -EINVAL should be returned or freq initialized to some default value

> +		return 0;
> +	}
> +
> +	input = mul0 * 100;
> +	do_div(input, div0);
> +	*freq = (u16)input;
> +
> +	return 0;
> +}
> +
>
> +
> +static int clock_verify_freq(struct clock *clock)
> +{
> +	u32 lookup_freq, clock_freq_counter, request_in_khz, tolerance;
> +	int err = 0;
> +	u16 freq;
> +
> +	mutex_lock(&clock->clock_lock);
> +
> +	err = get_freq(clock, &freq);
> +	if (err) {
> +		xrt_err(clock->xdev, "get freq failed, %d", err);
> +		goto end;
> +	}
> +
> +	err = get_freq_counter(clock, &clock_freq_counter);
> +	if (err) {
> +		xrt_err(clock->xdev, "get freq counter failed, %d", err);
> +		goto end;
> +	}
> +
> +	lookup_freq = find_matching_freq(freq, frequency_table,
> +					 ARRAY_SIZE(frequency_table));

I am running v6 through clang's static analyzer, it shows a problem here

drivers/fpga/xrt/lib/xleaf/clock.c:474:16: warning: 1st function call 
argument is an uninitialized value
         lookup_freq = find_matching_freq(freq, frequency_table,
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

See problem with get_freq above

Tom


