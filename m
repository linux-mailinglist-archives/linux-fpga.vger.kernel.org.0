Return-Path: <linux-fpga+bounces-51-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F259A806FA2
	for <lists+linux-fpga@lfdr.de>; Wed,  6 Dec 2023 13:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2FCA281AEB
	for <lists+linux-fpga@lfdr.de>; Wed,  6 Dec 2023 12:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6B6364D0;
	Wed,  6 Dec 2023 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlRCcDlx"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82630364C7;
	Wed,  6 Dec 2023 12:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1BDC433C8;
	Wed,  6 Dec 2023 12:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701865634;
	bh=SFu4/bR/AMrjm4JlTuMfP6+O1LKZw8xcETHgeCdmOcw=;
	h=From:List-Id:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UlRCcDlxBcdIYtZoPpzMTuhqHXiPWCYfA6idr0x7B3j3Y2UMcQ+waxv51fpaH13zM
	 zxfEclP72Liv5bjZpSgP6sDpzhrxzmK3JYaucrIB1EAhBZjXvf4/sAPiDQBTtVJAhX
	 AaGDCeqqHHBAhSRQF7QuWR3OnECuf/4QxAY40FEZf31Tla//HUoSY+Pgvm0AJ/fn3j
	 7dfkSQgkmcJJtou2/vXNZMiW0yDZuj7jH49rmmPIlZSL0zZAMSfR+smj12+l1E3BNJ
	 wnQ1zNYJ1Y624VCEyb3EArLu3uKZgp/f7+o+lHj+NmiWNUFj6Gu/R3Cj4GK20GbDSt
	 z+2M1Lo5wc4UQ==
From: Conor Dooley <conor@kernel.org>
To: soc@kernel.org,
	Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Russ Weight <russell.h.weight@intel.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: Re: [PATCH v3 0/6] PolarFire SoC Auto Update Support
Date: Wed,  6 Dec 2023 12:25:58 +0000
Message-Id: <20231206-catfight-trailing-47b7b547e79b@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231020-agreeably-filing-3d48708e6262@spud>
References: <20231020-agreeably-filing-3d48708e6262@spud>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1335; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=zTxZ7tRHD+kYdL3Atrz/x5KAMx98vgPG50Y04wXmGgk=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKkFGcHW+uFcuo67KtRWbXzAJcHVK2PBLG9zq8H3gOyPZ 98fK7zrKGVhEONgkBVTZEm83dcitf6Pyw7nnrcwc1iZQIYwcHEKwETq/jD8szAQym13+xgbeTva UWzKI+W50QJ8bS6WPW6nejyqOk5/YGRofxHUuPRLGNept/eWWBrNfvnPZIqGxIOCdzyLy81bgt/ zAwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Fri, 20 Oct 2023 14:18:38 +0100, Conor Dooley wrote:
> Hey all,
> 
> This patchset adds support for the "Auto Update" feature on PolarFire
> SoC that allows for writing an FPGA bistream to the SPI flash connected
> to the system controller.
> On powercycle (or reboot depending on how the firmware implements the
> openSBI SRST extension) "Auto Update" will take place, and program the
> FPGA with the contents of the SPI flash - provided that that image is
> valid and an actual upgrade from that already programmed.
> 
> [...]

Arnd, I've gone and applied this stuff since things have been dead
since I sent it & will send it to you for the upcoming mw in a few weeks.

[1/6] dt-bindings: soc: microchip: add a property for system controller flash
      https://git.kernel.org/conor/c/98d62e97c39f
[2/6] soc: microchip: mpfs: enable access to the system controller's flash
      https://git.kernel.org/conor/c/742aa6c563d2
[3/6] soc: microchip: mpfs: print service status in warning message
      https://git.kernel.org/conor/c/a8f00589be7b
[4/6] soc: microchip: mpfs: add auto-update subdev to system controller
      https://git.kernel.org/conor/c/fad13b5b73e0
[5/6] firmware: microchip: add PolarFire SoC Auto Update support
      https://git.kernel.org/conor/c/ec5b0f1193ad

Thanks,
Conor.

