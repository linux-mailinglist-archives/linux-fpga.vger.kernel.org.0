Return-Path: <linux-fpga+bounces-1302-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB60B21B91
	for <lists+linux-fpga@lfdr.de>; Tue, 12 Aug 2025 05:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB5A1772D9
	for <lists+linux-fpga@lfdr.de>; Tue, 12 Aug 2025 03:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688C72E4258;
	Tue, 12 Aug 2025 03:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sw9tdx3S"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE432E424B;
	Tue, 12 Aug 2025 03:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754968806; cv=none; b=aY79MCa6e5b9ALBxFXu4Mbs2w0sRJ9/I1auVbk5O4uGc1st+iMIFlqjlN+mHDLKIKzmJlXY/I09R6ueDTRNzD0Ro/+tV6QV/QIaK6y9PEfHHxKzN781Vfon4BTqQHf9x0yICgTRItAJadg1T10UFeenZMVaYamtr0o6zT89ILMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754968806; c=relaxed/simple;
	bh=HGwL2Cpxqc9hVM6X36G/L3EWkoN6i1ddB5veVLR6os4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m1c8eBv4P+XNpobdtOPJu8Fwzeimvwv5y15uf2hKyQ6LgbGvx/I9mgrjsPQxuYsyWmyzEdUEiR+f6DB5Nh1w0VNGlDb7ZSzFBOYD7DzwO1BH27Bbeyiz//zbucgPiXiMxHmxZsF6n2WYwwtbbZO7C9InpX/uoBogQoBXi0x9EdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sw9tdx3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AC3C4CEED;
	Tue, 12 Aug 2025 03:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754968805;
	bh=HGwL2Cpxqc9hVM6X36G/L3EWkoN6i1ddB5veVLR6os4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Sw9tdx3SEDWyYmQIZ23jyv30G6UsjonOKiwJlvYv14u2mzcuW6QtRjdv3bHQxt5Yz
	 FcgNC8+CYXnTtCIb5n7BvHvjYZysw1LlpmUaCMYdHPlKRKwv4AOlE73x1PtNBhxuAh
	 ArdMp7RuB2q2TMRbP/juli0bw3QsnuFKGBJHIVLnX3bmrYJArVM75N6coME2NgD7BR
	 KWq6rMDIvtAnKqHW0XS5mrUz/Ur6HwyEXVV6OEHIm9pYXreISQyneY5D1b764VjaMp
	 6SRVLPsLn0fqGL3Bl5G7ydZd45nJW4IGyzA/bYex+shA3eHR1ZmCHeGAKaefH3JVQA
	 KNRbHEHVgLIcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C0B383BF51;
	Tue, 12 Aug 2025 03:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Mark Intel PTP DFL ToD as orphaned
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175496881774.1990527.3789561485320833609.git-patchwork-notify@kernel.org>
Date: Tue, 12 Aug 2025 03:20:17 +0000
References: <20250808175324.8C4B7354@davehans-spike.ostc.intel.com>
In-Reply-To: <20250808175324.8C4B7354@davehans-spike.ostc.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, linux-fpga@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 tianfei.zhang@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 08 Aug 2025 10:53:24 -0700 you wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> This maintainer's email no longer works. Remove it from MAINTAINERS.
> Also mark the code as an Orphan.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: linux-fpga@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Tianfei Zhang <tianfei.zhang@intel.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: Mark Intel PTP DFL ToD as orphaned
    https://git.kernel.org/netdev/net/c/b56e9fb1c966

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



